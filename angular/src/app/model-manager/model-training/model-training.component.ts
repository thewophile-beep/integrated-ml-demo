import { Component, OnInit, Input } from '@angular/core';
import { mlTrainingModel } from '../../definitions/mlTrainingModel';
import { mlModel } from '../../definitions/mlModel';
import { ModelService } from '../../services/model.service';
import { FormBuilder, Validators } from '@angular/forms';
import { interval, Observable } from 'rxjs';
import { MatDialog } from '@angular/material/dialog';
import { ModelTrainingAlertNameTakenComponent } from '../model-training-alert-name-taken/model-training-alert-name-taken.component';
import { ModelTrainingLogComponent } from '../model-training-log/model-training-log.component'
import { ModelTrainingCreateDrconfigComponent } from '../model-training-create-drconfig/model-training-create-drconfig.component';
import { ModelTrainingAlterDrconfigComponent } from '../model-training-alter-drconfig/model-training-alter-drconfig.component';
import { map } from 'rxjs/operators';
@Component({
  selector: 'app-model-training',
  templateUrl: './model-training.component.html',
  styleUrls: ['./model-training.component.css']
})
export class ModelTrainingComponent implements OnInit {

  @Input() public fromTable = "";
  dataset = "";

  runs$!: Observable<mlTrainingModel[]>;
  displayedColumns: string[] = ["modelName",	"trainingRunName", 	"provider",	"startTimestamp",	"completedTimestamp",	"trainingDuration",	"runStatus",	"statusCode",	"settings",	"mlConfigurationName",	"trainingRunQuery", "log"]
  loopColumns: string[] = ["trainingRunName", 	"provider",	"startTimestamp",	"completedTimestamp",	"trainingDuration",	"runStatus",	"statusCode",	"settings",	"mlConfigurationName",	"trainingRunQuery"]

  models$!: Observable<mlModel[]>;

  DRExists = false

  nbOfIds = 0;
  percentageTable = 80;

  waiting: boolean = false;
  replaceRun: boolean = false;
  
  runForm = this.fb.group({
    runName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    modelName: ['', Validators.required],
    MLconfig: ['', Validators.required],
    tableSelection: [this.percentageTable, Validators.required]
  })
  
  constructor(
    private modelService: ModelService,
    private fb: FormBuilder, 
    public dialog: MatDialog, 
  ) { }
  
  ngOnInit(): void {
    this.dataset = this.fromTable.split('_')[0]
    this.getAll();
  }
  
  getAll(): void {
    this.runs$ = this.modelService.getTrainingRuns().pipe(
      map(runs => runs.filter(run => run.trainingRunQuery.includes(this.dataset)))
    )
    this.models$ = this.modelService.getAllModels().pipe(
      map(models => models.filter(model => model.defaultTrainingQuery.includes(this.dataset)))
    )
    this.modelService.getTableSize(this.fromTable).subscribe(response => this.nbOfIds = Number(response))
    this.modelService.getAllConfigurations().subscribe(response => {
      this.runForm.patchValue({MLconfig: response.defaultConfigName})
      if (response.configs.includes('DataRobotConfig')) {
        this.DRExists = true
      }
    })
  }

  onSubmit(): void {
    var isValid = true;
    // Name already taken ?
    this.runs$.subscribe(runs => 
      runs.forEach(run => {
        if (this.runForm.value.runName === run.trainingRunName) {
          isValid = false;
        }
      })
    )
    // If already taken
    if (!isValid) { 
      // Asks if want to replace 
      this.dialog.open(ModelTrainingAlertNameTakenComponent).afterClosed().subscribe(response => {
        if (response)
          this.postTraining()
      })
    } else {
      // If not taken, directly post the training
      this.postTraining()
    }
  }

  
  postTraining() {
    if (!this.DRExists && this.runForm.value.MLconfig === "DataRobotConfig") {
      this.dialog.open(ModelTrainingCreateDrconfigComponent).afterClosed().subscribe(response => {
        if (response) {
          this.trainModel()
        }
      })
    } else {
      this.trainModel()
    }
  }

  trainModel() {
    this.modelService.changeConfiguration(this.runForm.value.MLconfig).subscribe(_=> {
      const fromTable = this.fromTable + " WHERE ID <= " + Math.round((this.runForm.value.tableSelection / 100) * this.nbOfIds);
      const modelName = this.runForm.value.modelName
      const trainingName = this.runForm.value.runName
      this.modelService.trainModel(modelName, trainingName, fromTable).subscribe(
        _ => {
          // Checks every 3 seconds if the training is completed or failed
          const intervalObservable = interval(3000).subscribe(
            _ => {
              this.modelService.getStateTrainingRun(modelName, trainingName).subscribe(
                response => {
                  if (response === "completed" || response === "failed") {
                    // Need to unsubscribe to stop checking 
                    intervalObservable.unsubscribe()
                    this.runForm.patchValue({runName: '', modelName: ''})
                    this.getAll()
                    this.waiting = false;
                  };
                }
              );
            }
          );
          this.waiting = true;
        }
      );
    })
  }

  // Automatically give a name to the run
  defaultTrainingName() {
    const modelName = this.runForm.value.modelName
    if (modelName !== undefined) {
      const regExp = modelName + "_t[0-9]+"
      var i = 1
      var newName = modelName + "_t" + i
      this.runs$.subscribe(runs => 
        runs.forEach(run => {
          if (run.trainingRunName.match(regExp)) {
            i = Number(run.trainingRunName.split(`${modelName}_t`).pop()) + 1
            newName = modelName + "_t" + i
          }
        })
      )
      this.runForm.patchValue({runName: newName})
    }
  }

  log(trainingName: string) {
    this.modelService.getLogTrainingRun(trainingName).subscribe(
      response => {
        this.dialog.open(ModelTrainingLogComponent, {
          data: response
        });
      }
    )
  }

  openDRDialog() : void {
    if (this.DRExists)
      this.dialog.open(ModelTrainingAlterDrconfigComponent)
    else
      this.dialog.open(ModelTrainingCreateDrconfigComponent).afterClosed().subscribe(response => {
        if (response)
          this.getAll()
      })
  }
}

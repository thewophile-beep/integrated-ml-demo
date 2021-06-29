import { Component, OnInit, Input } from '@angular/core';
import { mlTrainingModel } from '../../definitions/mlTrainingModel';
import { mlModel } from '../../definitions/mlModel';
import { ModelService } from '../../services/model.service';
import { FormBuilder, Validators } from '@angular/forms';
import { interval, Observable } from 'rxjs';
import { MatDialog } from '@angular/material/dialog';
import { ModelTrainingAlertNameTakenComponent } from '../model-training-alert-name-taken/model-training-alert-name-taken.component';
import { PassengerService } from '../../services/passenger.service';

@Component({
  selector: 'app-model-training',
  templateUrl: './model-training.component.html',
  styleUrls: ['./model-training.component.css']
})
export class ModelTrainingComponent implements OnInit {

  @Input() public fromTable = "";

  runs: mlTrainingModel[] = [];
  displayedColumns: string[] = ["modelName",	"trainingRunName", 	"provider",	"startTimestamp",	"completedTimestamp",	"trainingDuration",	"runStatus",	"statusCode",	"log",	"settings",	"mlConfigurationName",	"trainingRunQuery"]
  loopColumns: string[] = ["trainingRunName", 	"provider",	"startTimestamp",	"completedTimestamp",	"trainingDuration",	"runStatus",	"statusCode",	"log",	"settings",	"mlConfigurationName",	"trainingRunQuery"]

  models: mlModel[] = [];

  nbOfIds = 0;
  percentageTable = 80;

  waiting: boolean = false;
  replaceRun: boolean = false;
  
  runForm = this.fb.group({
    runName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    modelName: ['', Validators.required],
    MLconfig: ["AutoML", Validators.required],
    tableSelection: [this.percentageTable, Validators.required]
  })
  
  constructor(
    private modelService: ModelService,
    private fb: FormBuilder, 
    public dialog: MatDialog, 
  ) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll(): void {
    this.modelService.getTrainingRuns().subscribe(response => this.runs = response.trainingRuns);
    this.modelService.getAllModels().subscribe(response => this.models = response.models);
    this.modelService.getTableSize(this.fromTable).subscribe(response => this.nbOfIds = response.total)
  }

  onSubmit(): void {
    var isValid = true;
    // Name already taken ?
    this.runs.forEach(run => {
      if (this.runForm.value.runName === run.trainingRunName) {
        isValid = false;
      }
    })
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
    const fromTable = this.fromTable + " WHERE ID <= " + Math.round((this.runForm.value.tableSelection / 100) * this.nbOfIds);
    const modelName = this.runForm.value.modelName
    const trainingName = this.runForm.value.runName
    this.modelService.changeConfiguration(this.runForm.value.MLconfig).subscribe(
      _=> {
        this.modelService.trainModel(modelName, trainingName, fromTable).subscribe(
          _ => {
            // Checks every 3 seconds if the training is completed or failed
            const intervalObservable = interval(3000).subscribe(
              _ => {
                this.modelService.getStateTrainingRun(modelName, trainingName).subscribe(
                  response => {
                    if (response.state === "completed" || response.state === "failed") {
                      // Need to unsubscribe to stop checking 
                      intervalObservable.unsubscribe()
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
      }
    );
  }

  // Automatically give a name to the run
  defaultTrainingName() {
    const modelName = this.runForm.value.modelName
    const regExp = modelName + "_t[0-9]+"
    var i = 1
    var newName = modelName + "_t" + i
    this.runs.forEach(run => {
      if (run.trainingRunName.match(regExp)) {
        i = i + 1
      }
      newName = modelName + "_t" + i
    })
    this.runForm.patchValue({runName: newName})
  }
}

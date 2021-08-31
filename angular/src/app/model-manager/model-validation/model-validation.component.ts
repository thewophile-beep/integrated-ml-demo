import { Component, Input, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { mlTrainedModel } from '../../definitions/mlTrainedModel';
import { ModelService } from '../../services/model.service';
import { FormBuilder, Validators } from '@angular/forms';
import { mlValidationRun } from '../../definitions/mlValidationRun';
import { ModelValidationMetricsComponent } from '../model-validation-metrics/model-validation-metrics.component';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';


@Component({
  selector: 'app-model-validation',
  templateUrl: './model-validation.component.html',
  styleUrls: ['./model-validation.component.css']
})
export class ModelValidationComponent implements OnInit {

  @Input() fromTable = "";

  // Array for all the validation runs
  validationRuns$!: Observable<mlValidationRun[]>;
  // Columns to show in table
  displayedColumnsRuns: string[] = ["modelName", "trainedModelName",   "validationRunName",   "startTimestamp",   "completedTimestamp",   "validationDuration",   "runStatus",   "statusCode",   "settings",   "validationRunQuery"]
  loopColumnsRuns: string[] = ["trainedModelName",   "validationRunName",   "startTimestamp",   "completedTimestamp",   "validationDuration",   "runStatus",   "statusCode",   "settings",   "validationRunQuery"]

  // Array for all the trained models
  trainedModels$!: Observable<mlTrainedModel[]>;
  // Columns to show in table
  displayedColumnsTrained: string[] = ["modelName",	"trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  loopColumnsTrained: string[] = ["trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  
  // Slider parameters
  nbOfIds = 0;
  percentageTable = 20;
  
  waiting: boolean = false;
  
  chosenModel: mlTrainedModel | undefined;
  
  validationForm = this.fb.group({
    validationName: ['', [Validators.pattern(/^\S*$/)]],
    fromTable: [false, Validators.required],
    tableSelection: [this.percentageTable, Validators.required]
  })

  constructor(
    private modelService: ModelService,
    public dialog: MatDialog,
    private fb: FormBuilder,
  ) { }

  ngOnInit(): void {
    this.getAll();
  }

  getAll() {
    this.trainedModels$ = this.modelService.getTrainedModels()
    this.validationRuns$ = this.modelService.getValidationRuns()
    this.modelService.getTableSize(this.fromTable).subscribe(response => this.nbOfIds = Number(response))
  }

  validate() {
    const fromTable = this.fromTable + " WHERE ID > " + Math.round((100 - this.validationForm.value.tableSelection) / 100 * this.nbOfIds);
    const validationName = this.validationForm.value.validationName
    var isValid = true;
    this.validationRuns$.subscribe(response => response.forEach(run => {
      if (validationName === run.validationRunName) {
        isValid = false;
      }
    }))
    if (this.chosenModel && isValid) {
      const modelName = this.chosenModel.modelName
      const trainedModelName = this.chosenModel.trainedModelName
      this.modelService.validateModel(modelName, validationName, trainedModelName, fromTable).subscribe(
        _=> {this.getAll(); this.waiting = false}
      );
      this.waiting = true;
    } else {
      alert("Validation run name already taken!")
    }
  }

  openValidationMetrics(validationRun: mlValidationRun) {
    this.dialog.open(ModelValidationMetricsComponent, {
      data: validationRun
    })
  }
}



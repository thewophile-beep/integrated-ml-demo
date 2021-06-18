import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { mlTrainedModel } from '../mlTrainedModel';
import { ModelService } from '../model.service';
import { FormBuilder, Validators } from '@angular/forms';
import { mlValidationRun } from '../mlValidationRun';
import { ModelValidationMetricsComponent } from '../model-validation-metrics/model-validation-metrics.component';


@Component({
  selector: 'app-model-validation',
  templateUrl: './model-validation.component.html',
  styleUrls: ['./model-validation.component.css']
})
export class ModelValidationComponent implements OnInit {
  validationRuns: mlValidationRun[] = [];
  displayedColumnsRuns: string[] = ["modelName", "trainedModelName",   "validationRunName",   "startTimestamp",   "completedTimestamp",   "validationDuration",   "runStatus",   "statusCode",   "log",   "settings",   "validationRunQuery"]
  loopColumnsRuns: string[] = ["trainedModelName",   "validationRunName",   "startTimestamp",   "completedTimestamp",   "validationDuration",   "runStatus",   "statusCode",   "log",   "settings",   "validationRunQuery"]
  
  trainedModels: mlTrainedModel[] = [];
  displayedColumnsTrained: string[] = ["modelName",	"trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  loopColumnsTrained: string[] = ["trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  chosenModel: mlTrainedModel | undefined;
  fromTable: string = "";

  waiting: boolean = false;

  validationForm = this.fb.group({
    validationName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    fromTable: [false, Validators.required],
  })

  constructor(private modelService: ModelService, public dialog: MatDialog, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.getAll();
  }

  getAll() {
    this.modelService.getTrainedModels().subscribe(response => this.trainedModels = response.models)
    this.modelService.getValidationRuns().subscribe(response => this.validationRuns = response.trainingRuns)
  }

  toggleWaiting(): void {
    this.waiting = !this.waiting;
  }

  choosingModel(choice: mlTrainedModel) {
    this.chosenModel = choice;
  }

  validate() {
    if (this.chosenModel) {
      if (this.validationForm.value.fromTable === true) {
        this.fromTable = "Titanic_Table.Passenger"
      } else {
        this.fromTable = "Titanic_Table.Passenger WHERE ID<892"
      }
      this.modelService.validateModel(this.chosenModel.modelName, this.validationForm.value.validationName, this.chosenModel.trainedModelName, this.fromTable).subscribe(
        _=> this.getAll()
      );
    }
  }

  openValidationMetrics(validationRun: mlValidationRun) {
    this.dialog.open(ModelValidationMetricsComponent, {
      data: validationRun
    })
  }
}



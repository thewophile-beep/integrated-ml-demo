import { Component, OnInit } from '@angular/core';
import { mlTrainedModel } from '../mlTrainedModel';
import { ModelService } from '../model.service'
import { mlModel } from '../mlModel';

import { MatDialog } from '@angular/material/dialog';
import { ModelPredictionDetailComponent } from '../model-prediction-detail/model-prediction-detail.component';

@Component({
  selector: 'app-model-prediction',
  templateUrl: './model-prediction.component.html',
  styleUrls: ['./model-prediction.component.css']
})
export class ModelPredictionComponent implements OnInit {
  trainedModels: mlTrainedModel[] = [];
  displayedColumns: string[] = ["modelName",	"trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  loopColumns: string[] = ["trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  chosenModel: mlTrainedModel | undefined;
  chosenPassenger: string | undefined;
  waiting: boolean = false;
  predictedValues: string[] = [];
  newPrediction: string = "";
  
  models: mlModel[] = [];

  constructor(private modelService: ModelService, public dialog: MatDialog) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll() {
    this.modelService.getTrainedModels().subscribe(response => this.trainedModels = response.models)
    this.modelService.getAllModels().subscribe(response => this.models = response.models);
  }
    
  predict(): void {
    const data = {
      model: "",
      trainedModel: "",
      predicting: "",
      withVariables: "",
      passenger: "",
      predictedValue: "",
    }
    if (this.chosenModel && this.chosenPassenger) {

      data.model = this.chosenModel.modelName;
      data.trainedModel = this.chosenModel.trainedModelName;
      const currModel = this.models.find(model => model.modelName === data.model);
      if (currModel) {
        data.predicting = currModel.predictingColumnName
        data.withVariables = currModel.withColumns;
      }

      data.passenger = this.chosenPassenger;
      this.modelService.predict(this.chosenModel.modelName, this.chosenModel.trainedModelName, this.chosenPassenger).subscribe(
        predicted => {
          this.newPrediction = String(predicted.predictedValue);
          if (this.newPrediction.length === 0)
            data.predictedValue = "Error :( try another model ?";
          if (this.chosenModel && this.chosenPassenger)
            data.predictedValue = this.newPrediction;
          this.toggleWaiting();
          this.dialog.open(ModelPredictionDetailComponent, {
            data: data
          });
        }
      )
      
      this.toggleWaiting();

    }
  }

  toggleWaiting(): void {
    this.waiting = !this.waiting;
  }

  choosingModel(choice: mlTrainedModel) {
    this.chosenModel = choice;
  }
}

    
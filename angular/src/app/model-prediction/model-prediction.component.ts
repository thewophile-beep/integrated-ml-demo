import { Component, OnInit } from '@angular/core';
import { mlTrainedModel } from '../mlTrainedModel';
import { ModelService } from '../model.service'
import { mlModel } from '../mlModel';

import { MatDialog } from '@angular/material/dialog';
import { ModelPredictionDetailComponent } from '../model-prediction-detail/model-prediction-detail.component';
import { Passenger } from '../passenger';

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
      probability: ""
    }

    if (this.chosenModel && this.chosenPassenger) {

      // Preparing data to send to dialog
      data.model = this.chosenModel.modelName;
      data.trainedModel = this.chosenModel.trainedModelName;
      const currModel = this.models.find(model => model.modelName === data.model);
      if (currModel) {
        data.predicting = currModel.predictingColumnName
        data.withVariables = currModel.withColumns;
      }
      data.passenger = this.chosenPassenger;

      // Predicting
      this.modelService.predict(this.chosenModel.modelName, this.chosenModel.trainedModelName, this.chosenPassenger).subscribe(
        predicted => {
          data.predictedValue = String(predicted.predictedValue);
          // if of type classification + prediction retreived, retreive probability too
          if (this.chosenModel && this.chosenPassenger && (this.chosenModel.modelType === "classification")) {
              this.modelService.probability(this.chosenModel.modelName, this.chosenModel.trainedModelName, data.predictedValue, this.chosenPassenger).subscribe(
                response => {

                  // Quick and ugly fix to pb with survived field:
                  if (response.probability < 0.5) {
                    data.probability = String(1 - response.probability)
                  } else {
                    data.probability = String(response.probability)
                  }
                  // End waiting
                  this.toggleWaiting();
                  // Launch dialog
                  this.dialog.open(ModelPredictionDetailComponent, {
                    data: data
                  });
                }
              )
          } else {
            // End waiting
            this.toggleWaiting();
            // Launch dialog
            this.dialog.open(ModelPredictionDetailComponent, {
              data: data
            });
          }
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

  retreiveId(passenger: Passenger) {
    this.chosenPassenger = String(passenger.passengerId);
  }
}

    
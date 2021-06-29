import { Component, OnInit } from '@angular/core';
import { mlTrainedModel } from '../../definitions/mlTrainedModel';
import { ModelService } from '../../services/model.service'
import { mlModel } from '../../definitions/mlModel';

import { MatDialog } from '@angular/material/dialog';
import { ModelPredictionDetailComponent } from '../model-prediction-detail/model-prediction-detail.component';
import { Passenger } from '../../definitions/passenger';

@Component({
  selector: 'app-model-prediction',
  templateUrl: './model-prediction.component.html',
  styleUrls: ['./model-prediction.component.css']
})
export class ModelPredictionComponent implements OnInit {
  trainedModels: mlTrainedModel[] = [];
  models: mlModel[] = [];
  
  // Displayed columns for showing trained models data
  displayedColumns: string[] = ["modelName",	"trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  // Will loop over the following array (we separated the modelName to make it sticky):
  loopColumns: string[] = ["trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]

  chosenModel: mlTrainedModel | undefined;
  chosenPassenger: string | undefined;
  predictedValues: string[] = [];
  newPrediction: string = "";

  waiting: boolean = false;
  fromTable = "Titanic_Table.Passenger";

  constructor(private modelService: ModelService, public dialog: MatDialog) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll() {
    this.modelService.getTrainedModels().subscribe(response => this.trainedModels = response.models)
    this.modelService.getAllModels().subscribe(response => this.models = response.models);
  }
    
  predict(): void {
    // Preparing data const to send to dialog
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
      // Filling in data to send to dialog
      data.model = this.chosenModel.modelName;
      data.trainedModel = this.chosenModel.trainedModelName;
      const currModel = this.models.find(model => model.modelName === data.model);
      if (currModel) {
        data.predicting = currModel.predictingColumnName
        data.withVariables = currModel.withColumns;
      }
      data.passenger = this.chosenPassenger;

      // Predicting
      this.modelService.predict(data.model, data.trainedModel, data.passenger, this.fromTable).subscribe(
        predicted => {
          data.predictedValue = String(predicted.predictedValue);
          // if of type classification + prediction retreived, retreive probability too
          if (this.chosenModel && this.chosenPassenger && (this.chosenModel.modelType === "classification")) {
              this.modelService.probability(data.model, data.trainedModel, data.predictedValue, data.passenger, this.fromTable).subscribe(
                response => {

                  // Quick and ugly fix to bug with query to get probability of survived field:
                  if (response.probability < 0.5) {
                    data.probability = String(1 - response.probability)
                  } else {
                    data.probability = String(response.probability)
                  }

                  // End waiting
                  this.waiting = false;
                  // Launch dialog with the data to show (w/ probability)
                  this.dialog.open(ModelPredictionDetailComponent, {
                    data: data
                  });
                }
              )
          } else {
            // End waiting
            this.waiting = false;
            // Launch dialog with the data to show (w/o probability)
            this.dialog.open(ModelPredictionDetailComponent, {
              data: data
            });
          }
        }
      )
      // Begin waiting
      this.waiting = true;
    }
  }

  choosingModel(choice: mlTrainedModel) {
    this.chosenModel = choice;
  }

  retreivePassenger(passenger: string) {
    this.chosenPassenger = passenger;
  }
}

    
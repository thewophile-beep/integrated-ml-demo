import { Component, OnInit, Input } from '@angular/core';
import { mlTrainedModel } from '../../definitions/mlTrainedModel';
import { ModelService } from '../../services/model.service'
import { mlModel } from '../../definitions/mlModel';

import { MatDialog } from '@angular/material/dialog';
import { ModelPredictionPassengerDetailComponent } from '../../titanic/model-prediction-passenger-detail/model-prediction-passenger-detail.component';
import { ModelPredictionPatientDetailComponent } from '../../noshow/model-prediction-patient-detail/model-prediction-patient-detail.component';

@Component({
  selector: 'app-model-prediction',
  templateUrl: './model-prediction.component.html',
  styleUrls: ['./model-prediction.component.css']
})
export class ModelPredictionComponent implements OnInit {
  @Input() fromTable = "";

  titanicTable = "Titanic_Table.Passenger"
  noshowTable = "Noshow_Table.Patient"

  trainedModels: mlTrainedModel[] = [];
  models: mlModel[] = [];
  // Displayed columns for showing trained models data
  displayedColumns: string[] = ["modelName",	"trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  // Will loop over the following array (we separated the modelName to make it sticky):
  loopColumns: string[] = ["trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]

  chosenModel: mlTrainedModel | undefined;
  chosenId: string | undefined;
  predictedValues: string[] = [];
  newPrediction: string = "";

  waiting: boolean = false;
  
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
      id: "",
      predictedValue: "",
      probability: ""
    }

    if (this.chosenModel && this.chosenId) {
      // Filling in data to send to dialog
      data.model = this.chosenModel.modelName;
      data.trainedModel = this.chosenModel.trainedModelName;
      const currModel = this.models.find(model => model.modelName === data.model);
      if (currModel) {
        data.predicting = currModel.predictingColumnName
        data.withVariables = currModel.withColumns;
      }
      data.id = this.chosenId;

      // Predicting
      this.modelService.predict(data.model, data.trainedModel, data.id, this.fromTable).subscribe(
        predicted => {
          data.predictedValue = String(predicted.predictedValue);
          // if of type classification + prediction retreived, retreive probability too
          if (this.chosenModel && this.chosenId && (this.chosenModel.modelType === "classification")) {
              this.modelService.probability(data.model, data.trainedModel, data.predictedValue, data.id, this.fromTable).subscribe(
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
                  this.openDialog(data)
                }
              )
          } else {
            // End waiting
            this.waiting = false;
            // Launch dialog with the data to show (w/o probability)
            this.dialog.open(ModelPredictionPassengerDetailComponent, {
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

  retreiveValue(id: string) {
    this.chosenId = id;
  }

  openDialog(data: any) {
    if (this.fromTable === this.titanicTable)
      this.dialog.open(ModelPredictionPassengerDetailComponent, {
        data: data
      });
    else if (this.fromTable === this.noshowTable) {
      this.dialog.open(ModelPredictionPatientDetailComponent, {
        data: data
      });
    }   
  }
}

    
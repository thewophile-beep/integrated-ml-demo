import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { Observable } from 'rxjs';
import { mlModel } from 'src/app/definitions/mlModel';
import { mlTrainedModel } from 'src/app/definitions/mlTrainedModel';
import { ModelService } from 'src/app/services/model.service';
import { ModelPredictionPassengerDetailComponent } from '../model-prediction-passenger-detail/model-prediction-passenger-detail.component';

@Component({
  selector: 'app-model-prediction-passenger',
  templateUrl: './model-prediction-passenger.component.html',
  styleUrls: ['./model-prediction-passenger.component.css']
})
export class ModelPredictionPassengerComponent implements OnInit {
  fromTable = "Titanic_Table.Passenger";

  trainedModels$!: Observable<mlTrainedModel[]>;
  models$!: Observable<mlModel[]>;
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
    this.trainedModels$ = this.modelService.getTrainedModels()
    this.models$ = this.modelService.getAllModels()
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
      data.model = this.chosenModel.modelName;
      data.trainedModel = this.chosenModel.trainedModelName;
      data.id = this.chosenId;
      
      this.models$.subscribe(models => {
        const currModel = models.find(model => model.modelName === data.model);
        if (currModel) {
          if (currModel.defaultTrainingQuery.includes("Noshow")) {
            alert("This model is used on the noshow dataset.")
          } else {
            // Filling in data to send to dialog
            data.predicting = currModel.predictingColumnName
            data.withVariables = currModel.withColumns;
            // Predicting
            this.modelService.predict(data.model, data.trainedModel, data.id, this.fromTable).subscribe(
              predicted => {
                data.predictedValue = predicted;
                // if of type classification + prediction retreived, retreive probability too
                if (this.chosenModel && this.chosenId && (this.chosenModel.modelType === "classification")) {
                    this.modelService.probability(data.model, data.trainedModel, data.predictedValue, data.id, this.fromTable).subscribe(
                      response => {
                        const probability = Number(response)
                        // Quick and ugly fix to bug: the query retreives sometimes the wrong probability (for the wrong class)
                        if (probability < 0.5) {
                          data.probability = String(1 - probability)
                        } else {
                          data.probability = String(probability)
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
      })
    }
  }

  retreiveValue(id: string) {
    this.chosenId = id;
  }

  openDialog(data: any) {
    this.dialog.open(ModelPredictionPassengerDetailComponent, {
      data: data
    });  
  }
}
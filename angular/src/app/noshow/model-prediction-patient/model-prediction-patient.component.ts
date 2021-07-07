import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { mlModel } from 'src/app/definitions/mlModel';
import { mlTrainedModel } from 'src/app/definitions/mlTrainedModel';
import { ModelService } from 'src/app/services/model.service';
import { environment } from 'src/environments/environment';
import { ModelPredictionPatientDetailComponent } from '../model-prediction-patient-detail/model-prediction-patient-detail.component';

@Component({
  selector: 'app-model-prediction-patient',
  templateUrl: './model-prediction-patient.component.html',
  styleUrls: ['./model-prediction-patient.component.css']
})
export class ModelPredictionPatientComponent implements OnInit {
  fromTable = environment.noshowTable;

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
      data.model = this.chosenModel.modelName;
      
      const currModel = this.models.find(model => model.modelName === data.model);
      if (currModel) {
        if (!currModel.defaultTrainingQuery.includes("Noshow")) {
          alert("This model is used on the titanic dataset.")
        } else {
          // Filling in data to send to dialog
          data.trainedModel = this.chosenModel.trainedModelName;
          data.predicting = currModel.predictingColumnName
          data.withVariables = currModel.withColumns;
          data.id = this.chosenId;
          // Predicting
          this.modelService.predict(data.model, data.trainedModel, data.id, this.fromTable).subscribe(
            predicted => {
              data.predictedValue = predicted.predictedValue;
              // if of type classification + prediction retreived, retreive probability too
              if (this.chosenModel && this.chosenId && (this.chosenModel.modelType === "classification")) {
                  this.modelService.probability(data.model, data.trainedModel, data.predictedValue, data.id, this.fromTable).subscribe(
                    response => {
    
                      // Quick and ugly fix to bug: the query retreives sometimes the wrong probability (for the wrong class)
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
                this.dialog.open(ModelPredictionPatientDetailComponent, {
                  data: data
                });
              }
            }
          )
          // Begin waiting
          this.waiting = true;
        }
      }
    }
  }

  choosingModel(choice: mlTrainedModel) {
    this.chosenModel = choice;
  }

  retreiveValue(id: string) {
    this.chosenId = id;
  }

  openDialog(data: any) {
    this.dialog.open(ModelPredictionPatientDetailComponent, {
      data: data
    });  
  }
}

import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { mlTrainedModel } from '../mlTrainedModel';
import { ModelService } from '../model.service'
import { MessageService } from '../message.service';

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
  
  constructor(private fb: FormBuilder, private modelService: ModelService, private messageService: MessageService) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll() {
    this.modelService.getTrainedModels().subscribe(response => this.trainedModels = response.models)
  }
    
  predict(): void {
    if (this.chosenModel && this.chosenPassenger) {
      this.modelService.predict(this.chosenModel.modelName, this.chosenModel.trainedModelName, this.chosenPassenger).subscribe(
        predicted => {
          this.newPrediction = String(predicted.predictedValue);
          if (this.newPrediction.length === 0)
            this.newPrediction = "Error :( try another model ?";
          if (this.chosenModel && this.chosenPassenger)
            this.predictedValues.push(this.chosenModel.modelName + "_" + this.chosenModel.trainedModelName + " for n°" 
              + this.chosenPassenger + ": " + this.newPrediction);
          this.toggleWaiting();}
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

    
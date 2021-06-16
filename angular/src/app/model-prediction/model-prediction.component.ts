import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { mlTrainedModel } from '../mlTrainedModel';
import { ModelService } from '../model.service'
import { mlModel } from '../mlModel';

@Component({
  selector: 'app-model-prediction',
  templateUrl: './model-prediction.component.html',
  styleUrls: ['./model-prediction.component.css']
})
export class ModelPredictionComponent implements OnInit {
  trainedModels: mlTrainedModel[] = [];
  displayedColumns: string[] = ["modelName",	"trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  loopColumns: string[] = ["trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]

  models: mlModel[] = [];

  predictedValue: string = "";

  predictForm = this.fb.group({
    modelName: [null, Validators.required],
    trainedModelName: [null, Validators.required],
    id: [null, Validators.required],
  })
  
  constructor(private fb: FormBuilder, private modelService: ModelService) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll() {
    this.modelService.getTrainedModels().subscribe(
      trainedModels => this.trainedModels = trainedModels
    )
    this.modelService.getAllModels().subscribe(models => this.models = models);
    }
    
    predict(): void {
      this.modelService.predict(this.predictForm.value.modelName, this.predictForm.value.trainedModelName, this.predictForm.value.id).subscribe(
        predicted => this.predictedValue = predicted
      )
    }
  }
  
import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ML_TRAINED_MODELS } from '../ML_TRAINED_MODELS';
import { ModelService } from '../model.service'

@Component({
  selector: 'app-model-prediction',
  templateUrl: './model-prediction.component.html',
  styleUrls: ['./model-prediction.component.css']
})
export class ModelPredictionComponent implements OnInit {
  trainedModels: ML_TRAINED_MODELS[] = [];
  displayedColumns: string[] = ["MODEL_NAME",	"TRAINED_MODEL_NAME",	"PROVIDER",	"TRAINED_TIMESTAMP",	"MODEL_TYPE",	"MODEL_INFO"]
  loopColumns: string[] = ["TRAINED_MODEL_NAME",	"PROVIDER",	"TRAINED_TIMESTAMP",	"MODEL_TYPE",	"MODEL_INFO"]

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
    }
    
    predict(): void {
      
    }
  }
  
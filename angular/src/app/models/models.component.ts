import { Component, OnInit } from '@angular/core';
import { ML_MODEL } from '../ML_MODEL';
import { ModelService } from '../model.service';
import { FormBuilder, Validators, } from '@angular/forms';

@Component({
  selector: 'app-models',
  templateUrl: './models.component.html',
  styleUrls: ['./models.component.css']
})
export class ModelsComponent implements OnInit {
  models: ML_MODEL[] = [];
  displayedColumns: string[] = ["MODEL_NAME", "DESCRIPTION", "PREDICTING_COLUMN_NAME", "PREDICTING_COLUMN_TYPE", "WITH_COLUMNS", "CREATE_TIMESTAMP", "DEFAULT_TRAINED_MODEL_NAME", "DEFAULT_SETTINGS", "DEFAULT_TRAINING_QUERY", "actions"]
  loopColumns: string[] = ["DESCRIPTION", "PREDICTING_COLUMN_NAME", "PREDICTING_COLUMN_TYPE", "WITH_COLUMNS", "CREATE_TIMESTAMP", "DEFAULT_TRAINED_MODEL_NAME", "DEFAULT_SETTINGS", "DEFAULT_TRAINING_QUERY"]

  modelForm = this.fb.group({
    modelName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    predicting: [null, Validators.required]
  })
  
  constructor(private modelService: ModelService, private fb: FormBuilder) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll(): void {
    this.modelService.getAllModels().subscribe(models => this.models = models);
  }
  
  delete(model: ML_MODEL): void {
    this.models = this.models.filter(h => h !== model);
    this.modelService.deleteModel(model.MODEL_NAME).subscribe(
      _ => this.getAll()
    );
  }
    
  onSubmit(): void {
    var isValid = true;
    this.models.forEach(model => {
      if (this.modelForm.value.modelName === model.MODEL_NAME) {
        isValid = false;
      }
    })
    if (isValid) {
      this.modelService.createModel(this.modelForm.value.modelName, this.modelForm.value.predicting).subscribe(
        _ => this.getAll()
      );
    } else {
      alert("Name already taken!");
    }
  }

}
    
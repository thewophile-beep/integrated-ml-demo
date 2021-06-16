import { Component, OnInit } from '@angular/core';
import { mlModel } from '../mlModel';
import { ModelService } from '../model.service';
import { FormBuilder, Validators, } from '@angular/forms';

@Component({
  selector: 'app-models',
  templateUrl: './models.component.html',
  styleUrls: ['./models.component.css']
})
export class ModelsComponent implements OnInit {
  models: mlModel[] = [];
  displayedColumns: string[] = ["modelName", "description", "predictingColumnName", "predictingColumnType", "withColumns", "createTimestamp", "defaultTrainedModelName", "defaultSettings", "defaultTrainingQuery", "actions"]
  loopColumns: string[] = ["description", "predictingColumnName", "predictingColumnType", "withColumns", "createTimestamp", "defaultTrainedModelName", "defaultSettings", "defaultTrainingQuery"]

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
  
  delete(model: mlModel): void {
    this.models = this.models.filter(h => h !== model);
    this.modelService.deleteModel(model.modelName).subscribe(
      _ => this.getAll()
    );
  }
    
  onSubmit(): void {
    var isValid = true;
    this.models.forEach(model => {
      if (this.modelForm.value.modelName === model.modelName) {
        isValid = false;
      }
    })
    if (isValid) {
      this.modelService.createModel(this.modelForm.value.modelName, this.modelForm.value.predicting, "Titanic_Table.Passenger", []).subscribe(
        _ => this.getAll()
      );
    } else {
      alert("Name already taken!");
    }
  }

}
    
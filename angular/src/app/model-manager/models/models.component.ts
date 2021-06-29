import { Component, Input, OnInit } from '@angular/core';
import { mlModel } from '../../mlModel';
import { ModelService } from '../../model.service';
import { FormBuilder, Validators } from '@angular/forms';
import { MatChip } from '@angular/material/chips';
@Component({
  selector: 'app-models',
  templateUrl: './models.component.html',
  styleUrls: ['./models.component.css']
})
export class ModelsComponent implements OnInit {
  models: mlModel[] = [];
  displayedColumns: string[] = ["modelName", "description", "predictingColumnName", "predictingColumnType", "withColumns", "createTimestamp", "defaultTrainedModelName", "defaultSettings", "defaultTrainingQuery", "actions"]
  loopColumns: string[] = ["description", "predictingColumnName", "predictingColumnType", "withColumns", "createTimestamp", "defaultTrainedModelName", "defaultSettings", "defaultTrainingQuery"]

  withVariables: string[] = [];
  
  @Input() public fromTable = "";
  @Input() public possibleVariables: Array<{name: string, value: string, selected: boolean}> = [];

  modelForm = this.fb.group({
    modelName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    predicting: [null, Validators.required],
    fromTable: [false, Validators.required],
  })
  

  constructor(
    private modelService: ModelService, 
    private fb: FormBuilder,
  ) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll(): void {
    this.modelService.getAllModels().subscribe(response => this.models = response.models);
  }
  
  delete(model: mlModel): void {
    this.models = this.models.filter(h => h !== model);
    this.modelService.deleteModel(model.modelName).subscribe(
      _ => this.getAll()
    );
  }
    
  onSubmit(): void {
    var isValid = true;
    // Name already taken ?
    this.models.forEach(model => {
      if (this.modelForm.value.modelName === model.modelName) {
        isValid = false;
      }
    })
    if (isValid) {
      // If not taken
      // Preparing variables -> needs to be like "varName varType"
      for (let i = 0; i < this.possibleVariables.length; i++) {
        if (this.possibleVariables[i].selected === true) {
          this.withVariables.push(this.possibleVariables[i].value)
        }
      }
      // Creating model
      this.modelService.createModel(this.modelForm.value.modelName, this.modelForm.value.predicting, this.fromTable, this.withVariables).subscribe(
        _ => this.getAll()
      );
    } else {
      // If name taken
      alert("Name already taken!");
    }
  }

  // To toggle selection of chips when clicked
  toggleSelection(chip: MatChip) {
    if (!chip.disabled) {
      chip.toggleSelected();
      const index = this.possibleVariables.findIndex(i => i.name === chip.value)
      this.possibleVariables[index].selected = !this.possibleVariables[index].selected;
    }
  }

  // Check to disable chips or not
  checkingPredicting(chip: MatChip): boolean {
    if (this.modelForm.value.predicting === chip.value) {
      if (chip.selected) {
        this.toggleSelection(chip);
      }
      return true;
    }
    return false;
  }
}
    
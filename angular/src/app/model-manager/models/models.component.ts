import { Component, Input, OnInit } from '@angular/core';
import { mlModel } from '../../definitions/mlModel';
import { ModelService } from '../../services/model.service';
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
    this.modelService.getAllModels().subscribe(response => {
      this.models = response.models,
      this.models = this.models.filter(model => model.defaultTrainingQuery.includes(this.fromTable.split('_')[0]))
    });
  }
  
  delete(model: mlModel): void {
    this.models = this.models.filter(h => h !== model);
    this.modelService.deleteModel(model.modelName).subscribe(
      _ => this.getAll()
    );
  }

  purge(model: mlModel): void {
    this.modelService.purgeModel(model.modelName).subscribe()
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
    // We change only if the chip is enabled (clicking on a disabled chip will not do anything)
    if (!chip.disabled) {
      // We toggle the selection
      chip.toggleSelected();
      // We look for the value of the chip (the corresponding variable) and toggle selection of found variable
      const index = this.possibleVariables.findIndex(i => i.name === chip.value)
      this.possibleVariables[index].selected = !this.possibleVariables[index].selected;
    }
  }

  // Check to disable chips or not
  checkingPredicting(chip: MatChip): boolean {
    // If the selected value to predict is the value of this chip
    if (this.modelForm.value.predicting === chip.value) {
      // We toggle the selection if selected (to have the predicting value to "not selected")
      if (chip.selected) {
        this.toggleSelection(chip);
      }
      // We disable the chip
      return true;
    }
    // Else the chip is enabled
    return false;
  }
}
    
import { Component, OnInit } from '@angular/core';
import { mlModel } from '../mlModel';
import { ModelService } from '../model.service';
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
  fromTable: string = "";

  possibleVariables = [
    {name:'survived', value: 'survived integer', selected: false},
    {name:'class', value: 'class integer', selected: false},
    {name:'name', value: 'name string', selected: false},
    {name:'sex', value: 'sex string', selected: false},
    {name:'age', value: 'age integer', selected: false},
    {name:'sibSp', value: 'sibSp integer', selected: false},
    {name:'parCh', value: 'parCh integer', selected: false},
    {name:'ticket', value: 'ticket string', selected: false},
    {name:'fare', value: 'fare numeric', selected: false},
    {name:'cabin', value: 'cabin string', selected: false},
    {name:'embarked', value: 'embarked string', selected: false},
  ]

  modelForm = this.fb.group({
    modelName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    predicting: [null, Validators.required],
    fromTable: [false, Validators.required],
  })
  
  constructor(private modelService: ModelService, private fb: FormBuilder) { }
  
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
    this.models.forEach(model => {
      if (this.modelForm.value.modelName === model.modelName) {
        isValid = false;
      }
    })
    if (isValid) {
      for (let i = 0; i < this.possibleVariables.length; i++) {
        if (this.possibleVariables[i].selected === true) {
          this.withVariables.push(this.possibleVariables[i].value)
        }
      }
      if (this.modelForm.value.fromTable === true) {
        this.fromTable = "Titanic_Table.Passenger"
      } else {
        this.fromTable = "Titanic_Table.Passenger WHERE ID<892"
      }
      this.modelService.createModel(this.modelForm.value.modelName, this.modelForm.value.predicting, this.fromTable, this.withVariables).subscribe(
        _ => this.getAll()
      );
    } else {
      alert("Name already taken!");
    }
  }

  toggleSelection(chip: MatChip) {
    if (!chip.disabled) {
      chip.toggleSelected();
      const index = this.possibleVariables.findIndex(i => i.name === chip.value)
      this.possibleVariables[index].selected = !this.possibleVariables[index].selected;
    }
  }

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
    
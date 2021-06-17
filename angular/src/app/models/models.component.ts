import { Component, OnInit } from '@angular/core';
import { mlModel } from '../mlModel';
import { ModelService } from '../model.service';
import { FormBuilder, Validators, FormArray } from '@angular/forms';
import { variableType } from './variableType';

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

  possibleVariables: variableType[] = [
    {name:'survived', value: 'survived integer'},
    {name:'class', value: 'class integer'},
    {name:'name', value: 'name string'},
    {name:'sex', value: 'sex string'},
    {name:'age', value: 'age integer'},
    {name:'sibSp', value: 'sibSp integer'},
    {name:'parCh', value: 'parCh integer'},
    {name:'ticket', value: 'ticket string'},
    {name:'fare', value: 'fare numeric'},
    {name:'cabin', value: 'cabin string'},
    {name:'embarked', value: 'embarked string'},
  ]

  modelForm = this.fb.group({
    modelName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    predicting: [null, Validators.required],
    fromTable: ['', Validators.required],
    survived: false,
    class: false,
    name: false,
    sex: false,
    age: false,
    sibSp: false,
    parCh: false,
    ticket: false,
    fare: false,
    cabin: false,
    embarked: false,
  })

  createChoices() {
    return this.modelForm.get('name');
  }
  
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
        if (this.modelForm.controls[this.possibleVariables[i].name].value === true) {
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

}
    
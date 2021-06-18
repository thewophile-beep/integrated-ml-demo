import { Component, OnInit } from '@angular/core';
import { MatDialog } from '@angular/material/dialog';
import { mlTrainedModel } from '../mlTrainedModel';
import { ModelService } from '../model.service';
import { FormBuilder, Validators } from '@angular/forms';


@Component({
  selector: 'app-model-validation',
  templateUrl: './model-validation.component.html',
  styleUrls: ['./model-validation.component.css']
})
export class ModelValidationComponent implements OnInit {
  trainedModels: mlTrainedModel[] = [];
  displayedColumns: string[] = ["modelName",	"trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  loopColumns: string[] = ["trainedModelName",	"provider",	"trainedTimestamp",	"modelType",	"modelInfo"]
  chosenModel: mlTrainedModel | undefined;
  waiting: boolean = false;

  modelForm = this.fb.group({
    validationName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    fromTable: [false, Validators.required],
  })

  constructor(private modelService: ModelService, public dialog: MatDialog, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.getAll();
  }

  getAll() {
    this.modelService.getTrainedModels().subscribe(response => this.trainedModels = response.models)
  }

  toggleWaiting(): void {
    this.waiting = !this.waiting;
  }

  choosingModel(choice: mlTrainedModel) {
    this.chosenModel = choice;
  }
}



import { Component, OnInit } from '@angular/core';
import { mlTrainingModel } from '../mlTrainingModel';
import { mlModel } from '../mlModel';
import { ModelService } from '../model.service';
import { FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-model-training',
  templateUrl: './model-training.component.html',
  styleUrls: ['./model-training.component.css']
})
export class ModelTrainingComponent implements OnInit {

  runs: mlTrainingModel[] = [];
  displayedColumns: string[] = ["modelName",	"trainingRunName", 	"provider",	"startTimestamp",	"completedTimestamp",	"trainingDuration",	"runStatus",	"statusCode",	"log",	"settings",	"mlConfigurationName",	"trainingRunQuery"]
  loopColumns: string[] = ["trainingRunName", 	"provider",	"startTimestamp",	"completedTimestamp",	"trainingDuration",	"runStatus",	"statusCode",	"log",	"settings",	"mlConfigurationName",	"trainingRunQuery"]

  models: mlModel[] = [];

  waiting: boolean = false;

  
  runForm = this.fb.group({
    runName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    modelName: ['', Validators.required],
    MLconfig: ["AutoML", Validators.required]
  })
  
  constructor(private modelService: ModelService, private fb: FormBuilder) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll(): void {
    this.modelService.getTrainingRuns().subscribe(runs => this.runs = runs);
    this.modelService.getAllModels().subscribe(models => this.models = models);
  }
  
  onSubmit(): void {
    this.modelService.changeConfiguration(this.runForm.value.MLconfig).subscribe(
      _=> {
        this.modelService.trainModel(this.runForm.value.modelName, this.runForm.value.runName).subscribe(
          _ => {this.toggleWaiting(); this.getAll(); this.runForm.reset()}
        );
      }
    );
    this.toggleWaiting();
  }

  toggleWaiting(): void {
    this.waiting = !this.waiting;
  }

}

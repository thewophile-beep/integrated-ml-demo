import { Component, OnInit } from '@angular/core';
import { ML_TRAINING_RUN } from '../ML_TRAINING_RUN';
import { ML_MODEL } from '../ML_MODEL';
import { ModelService } from '../model.service';
import { FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-model-training',
  templateUrl: './model-training.component.html',
  styleUrls: ['./model-training.component.css']
})
export class ModelTrainingComponent implements OnInit {

  runs: ML_TRAINING_RUN[] = [];
  displayedColumns: string[] = ["MODEL_NAME",	"TRAINING_RUN_NAME", 	"PROVIDER",	"START_TIMESTAMP",	"COMPLETED_TIMESTAMP",	"TRAINING_DURATION",	"RUN_STATUS",	"STATUS_CODE",	"LOG",	"SETTINGS",	"ML_CONFIGURATION_NAME",	"TRAINING_RUN_QUERY"]
  loopColumns: string[] = ["TRAINING_RUN_NAME", 	"PROVIDER",	"START_TIMESTAMP",	"COMPLETED_TIMESTAMP",	"TRAINING_DURATION",	"RUN_STATUS",	"STATUS_CODE",	"LOG",	"SETTINGS",	"ML_CONFIGURATION_NAME",	"TRAINING_RUN_QUERY"]

  models: ML_MODEL[] = [];

  waiting: boolean = false;

  
  runForm = this.fb.group({
    runName: ['', [Validators.required, Validators.pattern(/^\S*$/)]],
    modelName: [null, Validators.required, Validators.pattern(/^\S*$/)],
    MLconfig: ["AutoML", Validators.required]
  })
  
  constructor(private modelService: ModelService, private fb: FormBuilder) { }
  
  ngOnInit(): void {
    this.getAll();
  }
  
  getAll(): void {
    this.modelService.getTrainingRuns().subscribe(runs => this.runs = runs);
    this.models = [];
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

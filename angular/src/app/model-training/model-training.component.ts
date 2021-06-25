import { Component, OnInit } from '@angular/core';
import { mlTrainingModel } from '../mlTrainingModel';
import { mlModel } from '../mlModel';
import { ModelService } from '../model.service';
import { FormBuilder, Validators } from '@angular/forms';
import { interval, Observable } from 'rxjs';

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
    this.modelService.getTrainingRuns().subscribe(response => this.runs = response.trainingRuns);
    this.modelService.getAllModels().subscribe(response => this.models = response.models);
  }
  

  onSubmit(): void {
    const modelName = this.runForm.value.modelName
    const trainingName = this.runForm.value.runName
    this.modelService.changeConfiguration(this.runForm.value.MLconfig).subscribe(
      _=> {
        this.modelService.trainModel(modelName, trainingName).subscribe(
          _ => {
            const intervalObservable = interval(3000).subscribe(
              _ => {
                this.modelService.getStateTrainingRun(modelName, trainingName).subscribe(
                  response => {
                    if (response.state === "completed") {
                      this.toggleWaiting()
                      this.getAll()
                      this.runForm.reset()
                      intervalObservable.unsubscribe()
                    }
                  }
                )
              }
            )
          }
        )
      }
    )
    this.toggleWaiting()
  }

  toggleWaiting(): void {
    this.waiting = !this.waiting;
  }

}

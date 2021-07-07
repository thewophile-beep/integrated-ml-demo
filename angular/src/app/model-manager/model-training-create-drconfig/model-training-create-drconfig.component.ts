import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ModelService } from 'src/app/services/model.service';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-model-training-create-drconfig',
  templateUrl: './model-training-create-drconfig.component.html',
  styleUrls: ['./model-training-create-drconfig.component.css']
})
export class ModelTrainingCreateDrconfigComponent implements OnInit {

  configForm = this.fb.group({
    url: [environment.dataRobotUrl, Validators.required],
    apiToken: [null, Validators.required]
  })

  constructor(
    private fb: FormBuilder, 
    private modelService: ModelService) { }

  ngOnInit(): void {
  }

  onSubmit() {
    this.modelService.createDRConfiguration(this.configForm.value.url,this.configForm.value.apiToken).subscribe();
  }
}

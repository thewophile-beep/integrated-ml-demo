import { Component, Input, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ModelService } from 'src/app/services/model.service';

@Component({
  selector: 'app-model-training-create-drconfig',
  templateUrl: './model-training-create-drconfig.component.html',
  styleUrls: ['./model-training-create-drconfig.component.css']
})
export class ModelTrainingCreateDrconfigComponent implements OnInit {

  configForm = this.fb.group({
    url: ["https://app2.datarobot.com/api/v2", Validators.required],
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

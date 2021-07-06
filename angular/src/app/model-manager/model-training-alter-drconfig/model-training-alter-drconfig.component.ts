import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { ModelService } from 'src/app/services/model.service';

@Component({
  selector: 'app-model-training-alter-drconfig',
  templateUrl: './model-training-alter-drconfig.component.html',
  styleUrls: ['./model-training-alter-drconfig.component.css']
})
export class ModelTrainingAlterDrconfigComponent implements OnInit {

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
    this.modelService.alterDRConfiguration(this.configForm.value.url,this.configForm.value.apiToken).subscribe();
  }

}

import { Component, OnInit, Inject } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { mlValidationRun } from '../../definitions/mlValidationRun';
import { ModelService } from '../../services/model.service';

@Component({
  selector: 'app-model-validation-metrics',
  templateUrl: './model-validation-metrics.component.html',
  styleUrls: ['./model-validation-metrics.component.css']
})
export class ModelValidationMetricsComponent implements OnInit {

  validationMetrics: string[] = [];

  constructor(@Inject(MAT_DIALOG_DATA) public data: mlValidationRun, private modelService: ModelService) { }

  ngOnInit(): void {
    this.getAll();
  }

  getAll() {
    this.modelService.getMetrics(this.data.modelName, this.data.validationRunName).subscribe(response => this.validationMetrics = response.metrics)
  }
}

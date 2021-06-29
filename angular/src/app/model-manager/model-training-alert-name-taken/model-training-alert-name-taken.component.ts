import { Component, OnInit } from '@angular/core';
import { MatDialogRef } from '@angular/material/dialog';

@Component({
  selector: 'app-model-training-alert-name-taken',
  templateUrl: './model-training-alert-name-taken.component.html',
  styleUrls: ['./model-training-alert-name-taken.component.css']
})
export class ModelTrainingAlertNameTakenComponent implements OnInit {

  constructor(public dialogRef: MatDialogRef<ModelTrainingAlertNameTakenComponent>,) { }

  ngOnInit(): void {
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

}

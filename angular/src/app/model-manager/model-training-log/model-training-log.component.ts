import { Component, Inject, OnInit } from '@angular/core';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-model-training-log',
  templateUrl: './model-training-log.component.html',
  styleUrls: ['./model-training-log.component.css']
})
export class ModelTrainingLogComponent implements OnInit {

  colorArray = ['#bad5ff','#d7ffba','#ffc2d4','#fff1d4', '#d4ffdb', '#fff1d4'];

  splitLog: string[] = []

  constructor(
    @Inject(MAT_DIALOG_DATA) public log: string, 
  ) {}

  ngOnInit(): void {
    this.splitLog = this.log.split("\n\n")
  }

}

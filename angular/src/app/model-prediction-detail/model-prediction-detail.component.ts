import { Component, OnInit, Inject } from '@angular/core';
import { PassengerService } from "../passenger.service"

import { MAT_DIALOG_DATA } from '@angular/material/dialog';
import { Passenger } from '../passenger';

@Component({
  selector: 'app-model-prediction-detail',
  templateUrl: './model-prediction-detail.component.html',
  styleUrls: ['./model-prediction-detail.component.css']
})
export class ModelPredictionDetailComponent implements OnInit {

  passenger: {[key:string]: string} = {
    passengerId: "",
    survived: "",
    class: "",
    name: "",
    sex: "",
    age: "",
    sibSp: "",
    parCh: "",
    ticket: "",
    fare: "",
    cabin: "",
    embarked: "",
    ID: "same as passengerId"
  };
  variableList: string[] = [];

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, private passengerService: PassengerService) { }

  ngOnInit(): void {
    this.getPassenger();
    this.prepareVariableList();
  }

  getPassenger(): void {
    this.passengerService.getPassenger(this.data.passenger).subscribe(passenger => {
      this.passenger.passengerId = String(passenger.passengerId);
      this.passenger.survived = String(passenger.survived);
      this.passenger.class = String(passenger.class);
      this.passenger.name = passenger.name;
      this.passenger.sex = passenger.sex;
      this.passenger.age = String(passenger.age);
      this.passenger.sibSp = String(passenger.sibSp);
      this.passenger.parCh = String(passenger.parCh);
      this.passenger.ticket = passenger.ticket;
      this.passenger.fare = String(passenger.fare);
      this.passenger.cabin = passenger.cabin;
      this.passenger.embarked = passenger.embarked;
    });
  }

  prepareVariableList(): void {
    const str = this.data.withVariables.split(',');
    for (let i = 0; i < str.length; i++) {
      this.variableList.push(str[i].split(':')[0].trim())
    }
  }
}

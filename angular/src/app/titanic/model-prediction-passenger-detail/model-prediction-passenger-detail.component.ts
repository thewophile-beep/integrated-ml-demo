import { Component, OnInit, Inject } from '@angular/core';
import { PassengerService } from "../../services/passenger.service"

import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-model-prediction-passenger-detail',
  templateUrl: './model-prediction-passenger-detail.component.html',
  styleUrls: ['./model-prediction-passenger-detail.component.css']
})
export class ModelPredictionPassengerDetailComponent implements OnInit {

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

  // Filling in this.passenger object with injected data
  getPassenger(): void {
    this.passengerService.getPassenger(this.data.id).subscribe(passenger => {
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

  // Formatting variable list
  prepareVariableList(): void {
    const str = this.data.withVariables.split(',');
    for (let i = 0; i < str.length; i++) {
      this.variableList.push(str[i].split(':')[0].trim())
    }
  }
}

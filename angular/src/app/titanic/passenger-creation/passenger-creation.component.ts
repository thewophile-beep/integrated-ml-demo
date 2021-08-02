import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';

import { Passenger } from '../../definitions/passenger'
import { PassengerService } from "../../services/passenger.service"

@Component({
  selector: 'app-passenger-creation',
  templateUrl: './passenger-creation.component.html',
  styleUrls: ['./passenger-creation.component.css']
})
export class PassengerCreationComponent implements OnInit {
  passengerForm = this.fb.group({
    name: ["", Validators.required],
    sex: [""],
    age: ["", Validators.min(0)],
    pclass: ["", Validators.required],
    sibSp: [0, Validators.min(0)],
    parCh: [0, Validators.min(0)],
    ticket: "", 
    fare: ["", Validators.min(0)],
    cabin: "",
    embarked: "",
    survived: "",
  });

  constructor(private fb: FormBuilder, private passengerService: PassengerService) {}

  ngOnInit() {
  }

  // Post new passenger
  onSubmit(): void {
    this.passengerService.createPassenger(this.passengerForm.value).subscribe(
      (newPassenger: Passenger) => {
        alert("New Passenger created with id : " + newPassenger.passengerId);
        this.passengerForm.reset();
      }
    );
  }
}

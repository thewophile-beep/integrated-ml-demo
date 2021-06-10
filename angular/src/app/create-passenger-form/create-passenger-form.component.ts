import { Component } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';

import { Passenger } from '../passenger'
import { PassengerService } from "../passenger.service"


@Component({
  selector: 'app-create-passenger-form',
  templateUrl: './create-passenger-form.component.html',
  styleUrls: ['./create-passenger-form.component.css']
})
export class CreatePassengerFormComponent {
  passengerForm = this.fb.group({
    Name: [null, Validators.required],
    Sex: [null, Validators.required],
    Age: [null, Validators.required, Validators.min(0)],
    Pclass: [null, Validators.required],
    SibSp: [0, Validators.min(0)],
    Parch: [0, Validators.min(0)],
    Ticket: null, 
    Fare: [null, Validators.min(0)],
    Cabin: null,
    Embarked: null,
  });

  constructor(private fb: FormBuilder, private passengerService: PassengerService) {}

  ngOnInit() {
  }

  onSubmit(): void {
    let passenger = this.passengerForm.value;
    this.passengerService.createPassenger(passenger).subscribe(
      (newPassenger: Passenger) => alert("New Passenger created with id : " + newPassenger.Id)
    );
  }
}

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
    name: [null, Validators.required],
    sex: [null, Validators.required],
    age: [null, Validators.min(0)],
    class: [null, Validators.required],
    sibSp: [0, Validators.min(0)],
    parCh: [0, Validators.min(0)],
    ticket: null, 
    fare: [null, Validators.min(0)],
    cabin: null,
    embarked: null,
  });

  constructor(private fb: FormBuilder, private passengerService: PassengerService) {}

  ngOnInit() {
  }

  onSubmit(): void {
    this.passengerService.createPassenger(this.passengerForm.value).subscribe(
      (newPassenger: Passenger) => {
        alert("New Passenger created with id : " + newPassenger.passengerId);
        this.passengerForm.reset();
      }
    );
  }
}

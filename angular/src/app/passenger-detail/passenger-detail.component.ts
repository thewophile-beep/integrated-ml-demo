import { Component, OnInit, Inject } from '@angular/core';
import { Passenger } from "../passenger";

import { PassengerService } from "../passenger.service"

import { FormBuilder, Validators } from '@angular/forms';

import { MAT_DIALOG_DATA } from '@angular/material/dialog';



@Component({
  selector: 'app-passenger-detail',
  templateUrl: './passenger-detail.component.html',
  styleUrls: ['./passenger-detail.component.css']
})
export class PassengerDetailComponent implements OnInit {
  passenger: Passenger | undefined;

  passengerForm = this.fb.group({
    name: [null, Validators.required],
    sex: [null, Validators.required],
    age: [null, Validators.min(0)],
    class: [null, Validators.required],
    SibSp: [0, Validators.min(0)],
    Parch: [0, Validators.min(0)],
    ticket: null, 
    fare: [null, Validators.min(0)],
    cabin: null,
    embarked: null,
    survived: null,
  });

  constructor(
    private fb: FormBuilder,
    private passengerService: PassengerService,
    @Inject(MAT_DIALOG_DATA) public passengerId: number
  ) { }

  ngOnInit(): void {
    this.getPassenger();

  }

  getPassenger(): void {
    this.passengerService.getPassenger(this.passengerId).subscribe(passenger => {
      this.passenger = passenger;
      this.passengerForm.patchValue({
        name: passenger.name,
        sex: passenger.sex,
        ticket: passenger.ticket, 
        class: passenger.class,
        SibSp: passenger.sibSp,
        Parch: passenger.parCh,
        fare: passenger.fare,
        cabin: passenger.cabin,
        embarked: passenger.embarked,
        survived: passenger.survived,
        age: passenger.age,
      });
    });
  }

  update(): void {
    if (this.passenger) {
      this.passengerService.updatePassenger(this.passenger.passengerId, this.passengerForm.value)
        .subscribe();
    }
  }

}

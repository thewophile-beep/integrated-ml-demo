import { Component, OnInit, Input } from '@angular/core';
import { Passenger } from "../passenger";

import { PassengerService } from "../passenger.service"
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';

import { FormBuilder, Validators } from '@angular/forms';


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
    private route: ActivatedRoute,
    private location: Location
  ) { }

  ngOnInit(): void {
    this.getPassenger();

  }

  getPassenger(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.passengerService.getPassenger(id).subscribe(passenger => {
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

  goBack(): void {
    this.location.back();
  }

  update(): void {
    if (this.passenger) {
      this.passengerService.updatePassenger(this.passenger.passengerId, this.passengerForm.value)
        .subscribe(() => this.goBack());
    }
  }

}

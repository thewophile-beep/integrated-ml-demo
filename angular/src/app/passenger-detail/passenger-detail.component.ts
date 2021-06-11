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
    Name: [null, Validators.required],
    Sex: [null, Validators.required],
    Age: [null, Validators.min(0)],
    Pclass: [null, Validators.required],
    SibSp: [0, Validators.min(0)],
    Parch: [0, Validators.min(0)],
    Ticket: null, 
    Fare: [null, Validators.min(0)],
    Cabin: null,
    Embarked: null,
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
        Name: passenger.Name,
        Sex: passenger.Sex,
        Ticket: passenger.Ticket, 
        Pclass: passenger.Pclass,
        SibSp: passenger.SibSp,
        Parch: passenger.Parch,
        Fare: passenger.Fare,
        Cabin: passenger.Cabin,
        Embarked: passenger.Embarked,
        Age: passenger.Age,
      });
    });
  }

  goBack(): void {
    this.location.back();
  }

  update(): void {
    if (this.passenger) {
      this.passengerService.updatePassenger(this.passenger.Id, this.passenger)
        .subscribe(() => this.goBack());
    }
  }

}

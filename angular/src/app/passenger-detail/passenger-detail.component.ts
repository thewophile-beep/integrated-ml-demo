import { Component, OnInit, Input } from '@angular/core';
import { Passenger } from "../passenger";

import { PassengerService } from "../passenger.service"
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';

@Component({
  selector: 'app-passenger-detail',
  templateUrl: './passenger-detail.component.html',
  styleUrls: ['./passenger-detail.component.css']
})
export class PassengerDetailComponent implements OnInit {
  passenger: Passenger | undefined;

  constructor(
    private passengerService: PassengerService,
    private route: ActivatedRoute,
    private location: Location
  ) { }

  ngOnInit(): void {
    this.getPassenger();
  }

  getPassenger(): void {
    const id = Number(this.route.snapshot.paramMap.get('id'));
    this.passengerService.getPassenger(id).subscribe(passenger => this.passenger = passenger);
  }

  goBack(): void {
    this.location.back();
  }

  save(): void {
    if (this.passenger) {
      this.passengerService.updatePassenger(this.passenger.Id, this.passenger)
        .subscribe(() => this.goBack());
    }
  }

}

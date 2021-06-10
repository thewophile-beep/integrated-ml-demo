import { Component, OnInit, Input } from '@angular/core';
import { Passenger } from "../passenger";

import { PassengerService } from "../passenger.service"

@Component({
  selector: 'app-passenger-creation',
  templateUrl: './passenger-creation.component.html',
  styleUrls: ['./passenger-creation.component.css']
})
export class PassengerCreationComponent implements OnInit {
  passenger: Passenger | undefined
  checkbox_checked: boolean

  constructor(
    private passengerService: PassengerService,
  ) {
    this.checkbox_checked = false;
  }

  ngOnInit(): void {
    this.passenger = <Passenger>{}
  }

  save(): void {
    if (this.passenger) {
      this.passengerService.createPassenger(this.passenger)
        .subscribe();
    }
  }

}

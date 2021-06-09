import { Component, Inject, OnInit } from '@angular/core';
import { Passenger } from '../passenger';
import { PassengerService } from '../passenger.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
  styleUrls: ['./dashboard.component.css']
})
export class DashboardComponent implements OnInit {

  passengers: Passenger[] = [];

  constructor(private passengerService: PassengerService) { }

  ngOnInit(): void {
    this.getPassengers();
  }

  getPassengers(): void {
    this.passengerService.getAllPassengers().subscribe(passengers => this.passengers = passengers.slice(1, 5));
  }
}

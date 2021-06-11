import { Component, OnInit } from '@angular/core';
import { Passenger } from '../passenger';
import { PassengerService } from '../passenger.service';
import { MessageService } from '../message.service'

@Component({
    selector: 'app-passengers',
    templateUrl: './passengers.component.html',
    styleUrls: ['./passengers.component.css']
})
export class PassengersComponent implements OnInit {    
    passengers: Passenger[] = [];
    
    constructor(private passengerService: PassengerService) {}
    
    ngOnInit() {
        this.getAll();
    }
    
    getAll(): void {
        this.passengerService.getAllPassengers().subscribe(passengers => this.passengers = passengers);
    }

    delete(passenger: Passenger): void {
        this.passengers = this.passengers.filter(h => h !== passenger);
        this.passengerService.deletePassenger(passenger.Id).subscribe();
    }
}
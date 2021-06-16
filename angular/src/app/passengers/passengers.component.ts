import { Component, OnInit } from '@angular/core';
import { Passenger } from '../passenger';
import { PassengerService } from '../passenger.service';
import {PageEvent} from '@angular/material/paginator';

import { MatDialog } from '@angular/material/dialog';
import { PassengerDetailComponent } from '../passenger-detail/passenger-detail.component';


@Component({
    selector: 'app-passengers',
    templateUrl: './passengers.component.html',
    styleUrls: ['./passengers.component.css']
})
export class PassengersComponent implements OnInit {    
    passengers: Passenger[] = [];
    pageSize: number = 100;
    currPage: number = 0;
    totalNum: number | undefined;

    constructor(private passengerService: PassengerService, public dialog: MatDialog) {}
    
    ngOnInit() {
        this.getAll();
    }
    
    getAll(): void {
        this.passengerService.getAllPassengers(this.currPage, this.pageSize).subscribe(
            passengers => {
                this.totalNum = Number(passengers[0]),
                this.passengers = passengers.slice(1, this.pageSize + 1)
            }
        );
    }

    delete(passenger: Passenger): void {
        this.passengers = this.passengers.filter(h => h !== passenger);
        this.passengerService.deletePassenger(passenger.passengerId).subscribe(
            _ => this.getAll()
        );
    }

    updateEvent(event: PageEvent): void {
        this.pageSize = event.pageSize;
        this.currPage = event.pageIndex;
        this.getAll();
    }

    openDialog(passenger: Passenger) {
        this.dialog.open(PassengerDetailComponent, {
          data: passenger.passengerId
        });
      }

}
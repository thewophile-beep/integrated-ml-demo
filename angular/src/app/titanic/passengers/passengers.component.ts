import { Component, OnInit } from '@angular/core';
import { Passenger } from '../../definitions/passenger';
import { PassengerService } from '../../services/passenger.service';
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
            response => {
                this.totalNum = Number(response.total),
                this.passengers = response.passengers
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
        const passengerDialog = this.dialog.open(PassengerDetailComponent, {
            data: passenger.passengerId
        });
        passengerDialog.afterClosed().subscribe(() => this.getAll());
    }

}
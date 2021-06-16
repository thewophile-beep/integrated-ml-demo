import { Component, OnInit } from '@angular/core';

import { Observable, Subject } from 'rxjs';

import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';

import { Passenger } from '../passenger';
import { PassengerService } from '../passenger.service';

import { MatDialog } from '@angular/material/dialog';
import { PassengerDetailComponent } from '../passenger-detail/passenger-detail.component';

@Component({
  selector: 'app-passenger-search',
  templateUrl: './passenger-search.component.html',
  styleUrls: [ './passenger-search.component.css' ]
})
export class PassengerSearchComponent implements OnInit {
  passengers$!: Observable<Passenger[]>;
  private searchTerms = new Subject<string>();

  constructor(private passengerService: PassengerService, public dialog: MatDialog) {}

  // Push a search term into the observable stream.
  search(term: string): void {
    this.searchTerms.next(term);
  }

  ngOnInit(): void {
    this.passengers$ = this.searchTerms.pipe(
      // wait 300ms after each keystroke before considering the term
      debounceTime(300),

      // ignore new term if same as previous term
      distinctUntilChanged(),

      // switch to new search observable each time the term changes
      switchMap((term: string) => this.passengerService.searchPassengers(term)),
    );
  }

  openDialog(passenger: Passenger) {
    this.dialog.open(PassengerDetailComponent, {
      data: passenger.passengerId
    });
  }
}
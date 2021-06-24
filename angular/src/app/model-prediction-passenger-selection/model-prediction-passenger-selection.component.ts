import { Component, OnInit, EventEmitter, Output } from '@angular/core';

import { Passenger } from '../passenger';
import { PassengerService } from '../passenger.service';

import { Observable, Subject } from 'rxjs';
import { debounceTime, distinctUntilChanged, switchMap } from 'rxjs/operators';

import { MatDialog } from '@angular/material/dialog';
import { PassengerDetailComponent } from '../passenger-detail/passenger-detail.component';




@Component({
  selector: 'app-model-prediction-passenger-selection',
  templateUrl: './model-prediction-passenger-selection.component.html',
  styleUrls: ['./model-prediction-passenger-selection.component.css']
})
export class ModelPredictionPassengerSelectionComponent implements OnInit {
  passengers$!: Observable<Passenger[]>;
  private searchTerms = new Subject<string>();

  @Output() chosenPassenger = new EventEmitter<Passenger>()

  constructor(private passengerService: PassengerService, public dialog: MatDialog) { }

  ngOnInit(): void {
    this.passengers$ = this.searchTerms.pipe(
      // wait 300ms after each keystroke before considering the term
      debounceTime(300),

      // ignore new term if same as previous term
      distinctUntilChanged(),

      // switch to new search observable each time the term changes
      switchMap((term: string) => this.passengerService.searchPassengers(term))
    );
  }

  search(term: string): void {
    this.searchTerms.next(term);
  }

  choosePassenger(passenger: Passenger) {
    this.chosenPassenger.emit(passenger);
  }
  
  openDialog(passenger: Passenger) {
    this.dialog.open(PassengerDetailComponent, {
      data: passenger.passengerId
    });
  }
}

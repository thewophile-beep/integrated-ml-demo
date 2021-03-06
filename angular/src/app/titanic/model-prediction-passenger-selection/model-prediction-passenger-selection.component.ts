import { Component, OnInit, EventEmitter, Output } from '@angular/core';

import { Passenger } from '../../definitions/passenger';
import { PassengerService } from '../../services/passenger.service';

import { Observable, Subject } from 'rxjs';
import { debounceTime, switchMap } from 'rxjs/operators';

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
  lastTerm: string = "";
  chosenPassengerLocal: Passenger |¬†undefined;

  @Output() chosenId = new EventEmitter<string>()

  constructor(private passengerService: PassengerService, public dialog: MatDialog) { }

  ngOnInit(): void {
    this.passengers$ = this.searchTerms.pipe(
      // wait 300ms after each keystroke before considering the term
      debounceTime(300),

      // switch to new search observable each time the term changes
      switchMap((term: string) => this.passengerService.searchPassengers(term))
    );
  }

  search(term: string): void {
    this.lastTerm = term;
    this.searchTerms.next(term);
  }

  choosePassenger(passenger: Passenger) {
    this.chosenPassengerLocal = passenger;
    this.chosenId.emit(String(passenger.passengerId));
  }
  
  openDialog(passenger: Passenger) {
    const passengerDialog = this.dialog.open(PassengerDetailComponent, {
      data: passenger.passengerId
    });
    // Reloading the searched list
    passengerDialog
      .afterClosed()
      .subscribe(() => {
        this.search(this.lastTerm)
      })
  }
}

import { Component, OnInit } from '@angular/core';

import { Observable, Subject } from 'rxjs';

import { debounceTime, switchMap } from 'rxjs/operators';

import { Patient } from '../../definitions/patient';
import { PatientService } from '../../services/patient.service';

import { MatDialog } from '@angular/material/dialog';
import { PatientDetailComponent } from '../patient-detail/patient-detail.component';


@Component({
  selector: 'app-patient-search',
  templateUrl: './patient-search.component.html',
  styleUrls: [ './patient-search.component.css' ]
})
export class PatientSearchComponent implements OnInit {
  patients$!: Observable<Patient[]>;
  private searchTerms = new Subject<string>();
  lastTerm: string = "";

  constructor(private patientService: PatientService, public dialog: MatDialog) {}

  // Push a search term into the observable stream.
  search(term: string): void {
    this.lastTerm = term;
    this.searchTerms.next(term);
  }

  ngOnInit(): void {
    this.patients$ = this.searchTerms.pipe(
      // wait 300ms after each keystroke before considering the term
      debounceTime(300),

      // switch to new search observable each time the term changes
      switchMap((term: string) => this.patientService.searchPatients(term))
    );
  }

  openDialog(patient: Patient) {
    const patientDialog = this.dialog.open(PatientDetailComponent, {data: patient.patientId})
    patientDialog
      .afterClosed()
      .subscribe(() => 
        this.search(this.lastTerm)
      )
  }
}
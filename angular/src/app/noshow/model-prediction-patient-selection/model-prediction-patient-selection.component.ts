import { Component, OnInit, EventEmitter, Output } from '@angular/core';

import { Patient } from '../../definitions/patient';
import { PatientService } from '../../services/patient.service';

import { Observable, Subject } from 'rxjs';
import { debounceTime, switchMap } from 'rxjs/operators';

import { MatDialog } from '@angular/material/dialog';
import { PatientDetailComponent } from '../patient-detail/patient-detail.component';

@Component({
  selector: 'app-model-prediction-patient-selection',
  templateUrl: './model-prediction-patient-selection.component.html',
  styleUrls: ['./model-prediction-patient-selection.component.css']
})
export class ModelPredictionPatientSelectionComponent implements OnInit {
  patients$!: Observable<Patient[]>;
  private searchTerms = new Subject<string>();
  lastTerm: string = "";
  chosenPatientLocal: Patient | undefined;

  @Output() chosenId = new EventEmitter<string>()

  constructor(private patientService: PatientService, public dialog: MatDialog) { }

  ngOnInit(): void {
    this.patients$ = this.searchTerms.pipe(
      // wait 300ms after each keystroke before considering the term
      debounceTime(300),

      // switch to new search observable each time the term changes
      switchMap((term: string) => this.patientService.searchPatients(term))
    );
  }

  search(term: string): void {
    this.lastTerm = term;
    this.searchTerms.next(term);
  }

  choosePatient(patient: Patient) {
    this.chosenPatientLocal = patient;
    this.chosenId.emit(String(patient.patientId));
  }
  
  openDialog(patient: Patient) {
    const patientDialog = this.dialog.open(PatientDetailComponent, {
      data: patient.patientId
    });
    // Reloading the searched list
    patientDialog
      .afterClosed()
      .subscribe(() => {
        this.search(this.lastTerm)
      })
  }
}

import { Component, OnInit, Inject } from '@angular/core';
import { Patient } from "../../definitions/patient";

import { PatientService } from "../../services/patient.service"

import { FormBuilder, Validators } from '@angular/forms';

import { MAT_DIALOG_DATA } from '@angular/material/dialog';

// See model-prediction-detail (similar)

@Component({
  selector: 'app-patient-detail',
  templateUrl: './patient-detail.component.html',
  styleUrls: ['./patient-detail.component.css']
})
export class PatientDetailComponent implements OnInit {
  patient: Patient | undefined;

  patientForm = this.fb.group({
    gender: [null, Validators.required],
    age: [null, Validators.required],
    neighborhood: [null, Validators.required],
    scholarship: null,
    hypertension: null,
    diabetes: null,
    alcoholism: null,
    handicap: null,
    smsReceived: null,
    noShow: null,
    scheduledDay: [null, Validators.required],
    appointmentDay: [null, Validators.required],
  });

  constructor(
    private fb: FormBuilder,
    private patientService: PatientService,
    @Inject(MAT_DIALOG_DATA) public patientId: number
  ) { }

  ngOnInit(): void {
    this.getPatient();

  }

  getPatient(): void {
    this.patientService.getPatient(this.patientId).subscribe(patient => {
      this.patient = patient;
      this.patientForm.patchValue({
        patientId: patient.patientId,
        gender: patient.gender,
        scheduledDay: patient.scheduledDay,
        appointmentDay: patient.appointmentDay,
        age: patient.age,
        neighborhood: patient.neighborhood,
        scholarship: patient.scholarship,
        hypertension: patient.hypertension,
        diabetes: patient.diabetes,
        alcoholism: patient.alcoholism,
        handicap: patient.handicap,
        smsReceived: patient.smsReceived,
        noShow: patient.noShow,
      });
    });
  }

  update(): void {
    if (this.patient) {
      this.patientService.updatePatient(this.patient.patientId, this.patientForm.value)
        .subscribe();
    }
  }

}

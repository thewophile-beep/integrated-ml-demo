import { Component, OnInit, Inject } from '@angular/core';
import { PatientService } from "../../services/patient.service"

import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-model-prediction-patient-detail',
  templateUrl: './model-prediction-patient-detail.component.html',
  styleUrls: ['./model-prediction-patient-detail.component.css']
})
export class ModelPredictionPatientDetailComponent implements OnInit {

  patient: {[key:string]: string} = {
    ID: "",
    appointmentId: "",
    gender: "",
    scheduledDay: "",
    appointmentDay: "",
    age: "",
    neighbourhood: "",
    scholarship: "",
    hypertension: "",
    diabetes: "",
    alcoholism: "",
    handicap: "",
    smsReceived: "",
    noShow: "",
  };
  variableList: string[] = [];

  constructor(@Inject(MAT_DIALOG_DATA) public data: any, private patientService: PatientService) { }

  ngOnInit(): void {
    this.getPatient();
    this.prepareVariableList();
  }

  // Filling in this.patient object with injected data
  getPatient(): void {
    this.patientService.getPatient(this.data.id).subscribe(patient => {
      this.patient.ID = String(patient.patientId);
      this.patient.appointmentId = String(patient.appointmentId);
      this.patient.gender = String(patient.gender);
      this.patient.scheduledDay = String(patient.scheduledDay);
      this.patient.appointmentDay = String(patient.appointmentDay);
      this.patient.age = String(patient.age);
      this.patient.neighbourhood = String(patient.neighbourhood);
      this.patient.scholarship = String(patient.scholarship);
      this.patient.hypertension = String(patient.hypertension);
      this.patient.diabetes = String(patient.diabetes);
      this.patient.alcoholism = String(patient.alcoholism);
      this.patient.handicap = String(patient.handicap);
      this.patient.smsReceived = String(patient.smsReceived);
      this.patient.noShow = String(patient.noShow);
    });
  }

  // Formatting variable list
  prepareVariableList(): void {
    const str = this.data.withVariables.split(',');
    for (let i = 0; i < str.length; i++) {
      this.variableList.push(str[i].split(':')[0].trim())
    }
  }
}

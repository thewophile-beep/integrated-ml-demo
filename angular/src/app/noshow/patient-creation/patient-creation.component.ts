import { Component, OnInit } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';
import { Patient } from 'src/app/definitions/patient';
import { PatientService } from 'src/app/services/patient.service';

@Component({
  selector: 'app-patient-creation',
  templateUrl: './patient-creation.component.html',
  styleUrls: ['./patient-creation.component.css']
})
export class PatientCreationComponent implements OnInit {
  patientForm = this.fb.group({
    gender: [null, Validators.required],
    scheduledDay: [null, Validators.required],
    appointmentDay: [null, Validators.required],
    age: [null, Validators.required],
    neighbourhood: [null, Validators.required],
    scholarship: null,
    hypertension: null,
    diabetes: null,
    alcoholism: null,
    handicap: null,
    smsReceived: null,
    noShow: null,
  });


  constructor(private fb: FormBuilder, private patientService: PatientService) {}

  ngOnInit() {
  }

  // Post new patient
  onSubmit(): void {
    this.patientForm.patchValue({
      noShow: this.patientForm.value.noShow? "Yes" : "No",
      scholarship: this.patientForm.value.scholarship? 1 : 0,
      hypertension: this.patientForm.value.hypertension? 1 : 0,
      diabetes: this.patientForm.value.diabetes? 1 : 0,
      handicap: this.patientForm.value.handicap? 1 : 0,
      alcoholism: this.patientForm.value.alcoholism? 1 : 0,
      smsReceived: this.patientForm.value.smsReceived? 1 : 0,
    })
    this.patientService.createPatient(this.patientForm.value).subscribe(
      (newPatient: Patient) => {
        alert("New Patient created with id : " + newPatient.patientId);
        this.patientForm.reset();
      }
    );
  }
}

import { Component } from '@angular/core';
import { FormBuilder, Validators } from '@angular/forms';

@Component({
  selector: 'app-create-passenger-form',
  templateUrl: './create-passenger-form.component.html',
  styleUrls: ['./create-passenger-form.component.css']
})
export class CreatePassengerFormComponent {
  passengerForm = this.fb.group({
    Name: [null, Validators.required],
    Sex: [null, Validators.required],
    Age: [null, Validators.required, Validators.min(0)],
    Pclass: [null, Validators.required],
    Sibsp: [0, Validators.min(0)],
    Parch: [0, Validators.min(0)],
    Ticket: null, 
    Fare: [null, Validators.min(0)],
    Cabin: null,
    Embarked: null,
  });

  hasUnitNumber = false;

  constructor(private fb: FormBuilder) {}

  onSubmit(): void {
    alert('Thanks!');
  }
}

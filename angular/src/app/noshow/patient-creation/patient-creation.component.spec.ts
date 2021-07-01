import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PatientCreationComponent } from './patient-creation.component';

describe('PatientCreationComponent', () => {
  let component: PatientCreationComponent;
  let fixture: ComponentFixture<PatientCreationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PatientCreationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PatientCreationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

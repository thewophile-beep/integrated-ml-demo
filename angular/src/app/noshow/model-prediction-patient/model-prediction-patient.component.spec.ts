import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionPatientComponent } from './model-prediction-patient.component';

describe('ModelPredictionPatientComponent', () => {
  let component: ModelPredictionPatientComponent;
  let fixture: ComponentFixture<ModelPredictionPatientComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionPatientComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionPatientComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionPatientDetailComponent } from './model-prediction-patient-detail.component';

describe('ModelPredictionPatientDetailComponent', () => {
  let component: ModelPredictionPatientDetailComponent;
  let fixture: ComponentFixture<ModelPredictionPatientDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionPatientDetailComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionPatientDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

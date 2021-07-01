import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionPatientSelectionComponent } from './model-prediction-patient-selection.component';

describe('ModelPredictionPatientSelectionComponent', () => {
  let component: ModelPredictionPatientSelectionComponent;
  let fixture: ComponentFixture<ModelPredictionPatientSelectionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionPatientSelectionComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionPatientSelectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

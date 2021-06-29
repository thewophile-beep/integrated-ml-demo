import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionPassengerSelectionComponent } from './model-prediction-passenger-selection.component';

describe('ModelPredictionPassengerSelectionComponent', () => {
  let component: ModelPredictionPassengerSelectionComponent;
  let fixture: ComponentFixture<ModelPredictionPassengerSelectionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionPassengerSelectionComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionPassengerSelectionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

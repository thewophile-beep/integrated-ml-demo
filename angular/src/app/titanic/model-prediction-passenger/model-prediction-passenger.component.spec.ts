import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionPassengerComponent } from './model-prediction-passenger.component';

describe('ModelPredictionPassengerComponent', () => {
  let component: ModelPredictionPassengerComponent;
  let fixture: ComponentFixture<ModelPredictionPassengerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionPassengerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionPassengerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

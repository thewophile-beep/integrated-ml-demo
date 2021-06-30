import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionPassengerDetailComponent } from './model-prediction-passenger-detail.component';

describe('ModelPredictionPassengerDetailComponent', () => {
  let component: ModelPredictionPassengerDetailComponent;
  let fixture: ComponentFixture<ModelPredictionPassengerDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionPassengerDetailComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionPassengerDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

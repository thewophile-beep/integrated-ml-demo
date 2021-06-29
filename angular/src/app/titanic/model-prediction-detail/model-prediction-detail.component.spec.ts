import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionDetailComponent } from './model-prediction-detail.component';

describe('ModelPredictionDetailComponent', () => {
  let component: ModelPredictionDetailComponent;
  let fixture: ComponentFixture<ModelPredictionDetailComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionDetailComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionDetailComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelPredictionComponent } from './model-prediction.component';

describe('ModelPredictionComponent', () => {
  let component: ModelPredictionComponent;
  let fixture: ComponentFixture<ModelPredictionComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelPredictionComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelPredictionComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

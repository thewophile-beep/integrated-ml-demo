import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelValidationMetricsComponent } from './model-validation-metrics.component';

describe('ModelValidationMetricsComponent', () => {
  let component: ModelValidationMetricsComponent;
  let fixture: ComponentFixture<ModelValidationMetricsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelValidationMetricsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelValidationMetricsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

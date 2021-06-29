import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelTrainingAlertNameTakenComponent } from './model-training-alert-name-taken.component';

describe('ModelTrainingAlertNameTakenComponent', () => {
  let component: ModelTrainingAlertNameTakenComponent;
  let fixture: ComponentFixture<ModelTrainingAlertNameTakenComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelTrainingAlertNameTakenComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelTrainingAlertNameTakenComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

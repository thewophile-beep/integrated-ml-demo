import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelTrainingComponent } from './model-training.component';

describe('ModelTrainingComponent', () => {
  let component: ModelTrainingComponent;
  let fixture: ComponentFixture<ModelTrainingComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelTrainingComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelTrainingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

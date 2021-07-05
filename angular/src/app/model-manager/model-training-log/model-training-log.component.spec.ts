import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelTrainingLogComponent } from './model-training-log.component';

describe('ModelTrainingLogComponent', () => {
  let component: ModelTrainingLogComponent;
  let fixture: ComponentFixture<ModelTrainingLogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelTrainingLogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelTrainingLogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

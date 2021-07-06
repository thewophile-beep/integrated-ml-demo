import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelTrainingCreateDrconfigComponent } from './model-training-create-drconfig.component';

describe('ModelTrainingCreateDrconfigComponent', () => {
  let component: ModelTrainingCreateDrconfigComponent;
  let fixture: ComponentFixture<ModelTrainingCreateDrconfigComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelTrainingCreateDrconfigComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelTrainingCreateDrconfigComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

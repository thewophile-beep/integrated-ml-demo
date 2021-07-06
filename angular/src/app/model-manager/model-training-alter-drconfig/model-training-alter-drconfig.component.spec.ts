import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ModelTrainingAlterDrconfigComponent } from './model-training-alter-drconfig.component';

describe('ModelTrainingAlterDrconfigComponent', () => {
  let component: ModelTrainingAlterDrconfigComponent;
  let fixture: ComponentFixture<ModelTrainingAlterDrconfigComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ModelTrainingAlterDrconfigComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ModelTrainingAlterDrconfigComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

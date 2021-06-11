import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PresentationDatasetComponent } from './presentation-dataset.component';

describe('PresentationDatasetComponent', () => {
  let component: PresentationDatasetComponent;
  let fixture: ComponentFixture<PresentationDatasetComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PresentationDatasetComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PresentationDatasetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

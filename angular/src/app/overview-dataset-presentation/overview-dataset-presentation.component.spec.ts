import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewDatasetPresentationComponent } from './overview-dataset-presentation.component';

describe('OverviewDatasetPresentationComponent', () => {
  let component: OverviewDatasetPresentationComponent;
  let fixture: ComponentFixture<OverviewDatasetPresentationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OverviewDatasetPresentationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewDatasetPresentationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

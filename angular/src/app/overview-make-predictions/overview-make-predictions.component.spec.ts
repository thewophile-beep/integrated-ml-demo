import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewMakePredictionsComponent } from './overview-make-predictions.component';

describe('OverviewMakePredictionsComponent', () => {
  let component: OverviewMakePredictionsComponent;
  let fixture: ComponentFixture<OverviewMakePredictionsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OverviewMakePredictionsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewMakePredictionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

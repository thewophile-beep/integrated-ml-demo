import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewTitanicPredictionsComponent } from './overview-titanic-predictions.component';

describe('OverviewTitanicPredictionsComponent', () => {
  let component: OverviewTitanicPredictionsComponent;
  let fixture: ComponentFixture<OverviewTitanicPredictionsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OverviewTitanicPredictionsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewTitanicPredictionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

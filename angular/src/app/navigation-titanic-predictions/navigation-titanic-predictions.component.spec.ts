import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationTitanicPredictionsComponent } from './navigation-titanic-predictions.component';

describe('NavigationTitanicPredictionsComponent', () => {
  let component: NavigationTitanicPredictionsComponent;
  let fixture: ComponentFixture<NavigationTitanicPredictionsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationTitanicPredictionsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationTitanicPredictionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationNoshowPredictionsComponent } from './navigation-noshow-predictions.component';

describe('NavigationNoshowPredictionsComponent', () => {
  let component: NavigationNoshowPredictionsComponent;
  let fixture: ComponentFixture<NavigationNoshowPredictionsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationNoshowPredictionsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationNoshowPredictionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

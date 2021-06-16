import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationMakePredictionsComponent } from './navigation-make-predictions.component';

describe('NavigationMakePredictionsComponent', () => {
  let component: NavigationMakePredictionsComponent;
  let fixture: ComponentFixture<NavigationMakePredictionsComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationMakePredictionsComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationMakePredictionsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

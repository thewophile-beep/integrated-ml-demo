import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationTitanicMainComponent } from './navigation-titanic-main.component';

describe('NavigationTitanicMainComponent', () => {
  let component: NavigationTitanicMainComponent;
  let fixture: ComponentFixture<NavigationTitanicMainComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationTitanicMainComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationTitanicMainComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

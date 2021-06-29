import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationTitanicModelManagerComponent } from './navigation-titanic-model-manager.component';

describe('NavigationTitanicModelManagerComponent', () => {
  let component: NavigationTitanicModelManagerComponent;
  let fixture: ComponentFixture<NavigationTitanicModelManagerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationTitanicModelManagerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationTitanicModelManagerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

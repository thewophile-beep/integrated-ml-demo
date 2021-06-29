import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationTitanicPresentationComponent } from './navigation-titanic-presentation.component';

describe('NavigationTitanicPresentationComponent', () => {
  let component: NavigationTitanicPresentationComponent;
  let fixture: ComponentFixture<NavigationTitanicPresentationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationTitanicPresentationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationTitanicPresentationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

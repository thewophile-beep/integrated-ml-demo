import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationNoshowPresentationComponent } from './navigation-noshow-presentation.component';

describe('NavigationNoshowPresentationComponent', () => {
  let component: NavigationNoshowPresentationComponent;
  let fixture: ComponentFixture<NavigationNoshowPresentationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationNoshowPresentationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationNoshowPresentationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

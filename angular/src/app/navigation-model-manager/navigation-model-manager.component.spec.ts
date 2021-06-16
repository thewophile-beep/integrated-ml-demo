import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationModelManagerComponent } from './navigation-model-manager.component';

describe('NavigationModelManagerComponent', () => {
  let component: NavigationModelManagerComponent;
  let fixture: ComponentFixture<NavigationModelManagerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationModelManagerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationModelManagerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

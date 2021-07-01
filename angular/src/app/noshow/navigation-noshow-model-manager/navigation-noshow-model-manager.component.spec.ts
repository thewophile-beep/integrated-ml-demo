import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationNoshowModelManagerComponent } from './navigation-noshow-model-manager.component';

describe('NavigationNoshowModelManagerComponent', () => {
  let component: NavigationNoshowModelManagerComponent;
  let fixture: ComponentFixture<NavigationNoshowModelManagerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationNoshowModelManagerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationNoshowModelManagerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

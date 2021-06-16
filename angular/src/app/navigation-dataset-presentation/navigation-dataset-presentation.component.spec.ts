import { ComponentFixture, TestBed } from '@angular/core/testing';

import { NavigationDatasetPresentationComponent } from './navigation-dataset-presentation.component';

describe('NavigationDatasetPresentationComponent', () => {
  let component: NavigationDatasetPresentationComponent;
  let fixture: ComponentFixture<NavigationDatasetPresentationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ NavigationDatasetPresentationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(NavigationDatasetPresentationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

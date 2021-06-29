import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewTitanicPresentationComponent } from './overview-titanic-presentation.component';

describe('OverviewTitanicPresentationComponent', () => {
  let component: OverviewTitanicPresentationComponent;
  let fixture: ComponentFixture<OverviewTitanicPresentationComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OverviewTitanicPresentationComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewTitanicPresentationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

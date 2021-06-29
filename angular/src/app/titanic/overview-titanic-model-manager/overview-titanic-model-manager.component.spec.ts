import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewTitanicModelManagerComponent } from './overview-titanic-model-manager.component';

describe('OverviewTitanicModelManagerComponent', () => {
  let component: OverviewTitanicModelManagerComponent;
  let fixture: ComponentFixture<OverviewTitanicModelManagerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OverviewTitanicModelManagerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewTitanicModelManagerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

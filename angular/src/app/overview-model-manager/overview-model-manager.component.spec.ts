import { ComponentFixture, TestBed } from '@angular/core/testing';

import { OverviewModelManagerComponent } from './overview-model-manager.component';

describe('OverviewModelManagerComponent', () => {
  let component: OverviewModelManagerComponent;
  let fixture: ComponentFixture<OverviewModelManagerComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ OverviewModelManagerComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(OverviewModelManagerComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

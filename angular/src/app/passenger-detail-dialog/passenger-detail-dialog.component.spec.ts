import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PassengerDetailDialogComponent } from './passenger-detail-dialog.component';

describe('PassengerDetailDialogComponent', () => {
  let component: PassengerDetailDialogComponent;
  let fixture: ComponentFixture<PassengerDetailDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PassengerDetailDialogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PassengerDetailDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

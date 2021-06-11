import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ExplicationProjetComponent } from './explication-projet.component';

describe('ExplicationProjetComponent', () => {
  let component: ExplicationProjetComponent;
  let fixture: ComponentFixture<ExplicationProjetComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ ExplicationProjetComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(ExplicationProjetComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

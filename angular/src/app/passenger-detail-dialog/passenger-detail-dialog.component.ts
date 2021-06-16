import { Component, OnInit, Inject } from '@angular/core';
import { Passenger } from '../passenger';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-passenger-detail-dialog',
  templateUrl: './passenger-detail-dialog.component.html',
  styleUrls: ['./passenger-detail-dialog.component.css']
})
export class PassengerDetailDialogComponent implements OnInit {

  constructor(@Inject(MAT_DIALOG_DATA) public passenger: Passenger) { }

  ngOnInit(): void {
  }

}

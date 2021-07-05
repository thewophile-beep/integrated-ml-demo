import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navigation-noshow-predictions',
  templateUrl: './navigation-noshow-predictions.component.html',
  styleUrls: ['./navigation-noshow-predictions.component.css']
})
export class NavigationNoshowPredictionsComponent implements OnInit {

  fromTable = "Noshow_Table.Appointment"

  constructor() { }

  ngOnInit(): void {
  }

}

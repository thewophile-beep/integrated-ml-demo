import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navigation-titanic-predictions',
  templateUrl: './navigation-titanic-predictions.component.html',
  styleUrls: ['./navigation-titanic-predictions.component.css']
})
export class NavigationTitanicPredictionsComponent implements OnInit {

  fromTable: string = "Titanic_Table.Passenger";

  constructor() { }

  ngOnInit(): void {
  }

}

import { Component, OnInit } from '@angular/core';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-navigation-titanic-predictions',
  templateUrl: './navigation-titanic-predictions.component.html',
  styleUrls: ['./navigation-titanic-predictions.component.css']
})
export class NavigationTitanicPredictionsComponent implements OnInit {

  fromTable = environment.titanicTable;

  constructor() { }

  ngOnInit(): void {
  }

}

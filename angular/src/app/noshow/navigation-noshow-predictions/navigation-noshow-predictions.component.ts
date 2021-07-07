import { Component, OnInit } from '@angular/core';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-navigation-noshow-predictions',
  templateUrl: './navigation-noshow-predictions.component.html',
  styleUrls: ['./navigation-noshow-predictions.component.css']
})
export class NavigationNoshowPredictionsComponent implements OnInit {

  fromTable = environment.noshowTable;

  constructor() { }

  ngOnInit(): void {
  }

}

import { Component, OnInit } from '@angular/core';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-navigation-titanic-model-manager',
  templateUrl: './navigation-titanic-model-manager.component.html',
  styleUrls: ['./navigation-titanic-model-manager.component.css']
})
export class NavigationTitanicModelManagerComponent implements OnInit {

  fromTable = environment.titanicTable;
  possibleVariables = environment.titanicVariables;
  
  constructor() { }

  ngOnInit(): void {
  }

}

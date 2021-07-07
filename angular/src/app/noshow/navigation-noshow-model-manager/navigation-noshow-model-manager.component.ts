import { Component, OnInit } from '@angular/core';
import { environment } from 'src/environments/environment';

@Component({
  selector: 'app-navigation-noshow-model-manager',
  templateUrl: './navigation-noshow-model-manager.component.html',
  styleUrls: ['./navigation-noshow-model-manager.component.css']
})
export class NavigationNoshowModelManagerComponent implements OnInit {

  fromTable = environment.noshowTable;
  possibleVariables = environment.noshowVariables;
  constructor() { }

  ngOnInit(): void {
  }

}

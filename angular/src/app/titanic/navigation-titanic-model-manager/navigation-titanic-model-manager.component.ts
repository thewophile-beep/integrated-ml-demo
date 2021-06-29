import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navigation-titanic-model-manager',
  templateUrl: './navigation-titanic-model-manager.component.html',
  styleUrls: ['./navigation-titanic-model-manager.component.css']
})
export class NavigationTitanicModelManagerComponent implements OnInit {

  fromTable: string = "Titanic_Table.Passenger";
  possibleVariables = [
    {name:'survived', value: 'survived integer', selected: false},
    {name:'class', value: 'class integer', selected: false},
    {name:'name', value: 'name string', selected: false},
    {name:'sex', value: 'sex string', selected: false},
    {name:'age', value: 'age integer', selected: false},
    {name:'sibSp', value: 'sibSp integer', selected: false},
    {name:'parCh', value: 'parCh integer', selected: false},
    {name:'ticket', value: 'ticket string', selected: false},
    {name:'fare', value: 'fare numeric', selected: false},
    {name:'cabin', value: 'cabin string', selected: false},
    {name:'embarked', value: 'embarked string', selected: false},
  ]
  
  constructor() { }

  ngOnInit(): void {
  }

}

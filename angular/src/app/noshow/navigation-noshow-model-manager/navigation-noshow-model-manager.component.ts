import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-navigation-noshow-model-manager',
  templateUrl: './navigation-noshow-model-manager.component.html',
  styleUrls: ['./navigation-noshow-model-manager.component.css']
})
export class NavigationNoshowModelManagerComponent implements OnInit {

  fromTable: string = "Noshow_Table.Appointment";
  possibleVariables = [
    {name:'noShow', value: 'noShow string', selected: false},
    {name:'gender', value: 'gender timestamp', selected: false},
    {name:'scheduledDay', value: 'scheduledDay timestamp', selected: false},
    {name:'appointmentDay', value: 'appointmentDay string', selected: false},
    {name:'age', value: 'age integer', selected: false},
    {name:'neighborhood', value: 'neighborhood integer', selected: false},
    {name:'scholarship', value: 'scholarship integer', selected: false},
    {name:'hypertension', value: 'hypertension integer', selected: false},
    {name:'diabetes', value: 'diabetes integer', selected: false},
    {name:'alcoholism', value: 'alcoholism integer', selected: false},
    {name:'handicap', value: 'handicap integer', selected: false},
    {name:'smsReceived', value: 'smsReceived integer', selected: false},
  ]
  constructor() { }

  ngOnInit(): void {
  }

}

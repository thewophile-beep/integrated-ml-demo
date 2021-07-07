// This file can be replaced during build by using the `fileReplacements` array.
// `ng build` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  url: "http://localhost:52775/api/integratedML/",
  dataRobotUrl: "https://app2.datarobot.com/api/v2",
  titanicTable: "Titanic_Table.Passenger",
  titanicVariables:  [
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
  ],
  noshowTable: "Noshow_Table.Appointment",
  noshowVariables: [
    {name:'noShow', value: 'noShow string', selected: false},
    {name:'gender', value: 'gender timestamp', selected: false},
    {name:'scheduledDay', value: 'scheduledDay timestamp', selected: false},
    {name:'scheduledHour', value: 'scheduledDay string', selected: false},
    {name:'appointmentDay', value: 'appointmentDay string', selected: false},
    {name:'age', value: 'age integer', selected: false},
    {name:'neighborhood', value: 'neighborhood integer', selected: false},
    {name:'scholarship', value: 'scholarship integer', selected: false},
    {name:'hypertension', value: 'hypertension integer', selected: false},
    {name:'diabetes', value: 'diabetes integer', selected: false},
    {name:'alcoholism', value: 'alcoholism integer', selected: false},
    {name:'handicap', value: 'handicap integer', selected: false},
    {name:'smsReceived', value: 'smsReceived integer', selected: false},
  ],
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/plugins/zone-error';  // Included with Angular CLI.

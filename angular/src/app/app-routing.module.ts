import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PassengersComponent } from './passengers/passengers.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { PassengerDetailComponent } from './passenger-detail/passenger-detail.component';

const routes: Routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full'},
  { path: 'passengers', component: PassengersComponent },
  { path: 'dashboard', component: DashboardComponent },
  { path: 'detail/:id', component: PassengerDetailComponent },
]

@NgModule({
  imports: [
    RouterModule.forRoot(routes)
  ],
  exports: [
    RouterModule
  ]
})
export class AppRoutingModule { }

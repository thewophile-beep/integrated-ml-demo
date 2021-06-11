import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PassengersComponent } from './passengers/passengers.component';
import { PassengerDetailComponent } from './passenger-detail/passenger-detail.component';
import { CreatePassengerFormComponent } from './create-passenger-form/create-passenger-form.component';
import { NavigationComponent } from './navigation/navigation.component';

const routes: Routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full'},
  { path: 'passengers', component: PassengersComponent },
  { path: 'detail/:id', component: PassengerDetailComponent },
  {path: 'creation', component: CreatePassengerFormComponent},
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

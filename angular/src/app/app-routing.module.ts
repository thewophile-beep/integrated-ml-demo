import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PassengerDetailComponent } from './passenger-detail/passenger-detail.component';
import { PresentationDatasetComponent } from './presentation-dataset/presentation-dataset.component'
import { ModelManagerComponent } from './model-manager/model-manager.component';

const routes: Routes = [
  { path: '', redirectTo: '/info', pathMatch: 'full'},
  { path: 'detail/:id', component: PassengerDetailComponent },
  {path: 'info', component: PresentationDatasetComponent},
  {path: 'ml', component: ModelManagerComponent}
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

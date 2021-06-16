import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { PassengerDetailComponent } from './passenger-detail/passenger-detail.component';
import { NavigationDatasetPresentationComponent } from './navigation-dataset-presentation/navigation-dataset-presentation.component'
import { NavigationModelManagerComponent } from './navigation-model-manager/navigation-model-manager.component';
import { NavigationMakePredictionsComponent } from './navigation-make-predictions/navigation-make-predictions.component';

const routes: Routes = [
  { path: '', redirectTo: '/info', pathMatch: 'full'},
  { path: 'detail/:id', component: PassengerDetailComponent },
  { path: 'info', component: NavigationDatasetPresentationComponent },
  { path: 'ml', component: NavigationModelManagerComponent },
  { path: 'ml/predictions', component: NavigationMakePredictionsComponent}
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

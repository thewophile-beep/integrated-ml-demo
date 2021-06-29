import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { NavigationDatasetPresentationComponent } from './navigation-dataset-presentation/navigation-dataset-presentation.component'
import { NavigationTitanicModelManagerComponent } from './navigation-titanic-model-manager/navigation-titanic-model-manager.component';
import { NavigationTitanicPredictionsComponent } from './navigation-titanic-predictions/navigation-titanic-predictions.component';

const routes: Routes = [
  { path: '', redirectTo: '/titanic/dataset', pathMatch: 'full'},
  { path: 'titanic/dataset', component: NavigationDatasetPresentationComponent },
  { path: 'titanic/ml/management', component: NavigationTitanicModelManagerComponent },
  { path: 'titanic/ml/predictions', component: NavigationTitanicPredictionsComponent}
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

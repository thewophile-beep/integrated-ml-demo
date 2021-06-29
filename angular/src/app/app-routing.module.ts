import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { NavigationTitanicPresentationComponent } from './titanic/navigation-titanic-presentation/navigation-titanic-presentation.component'
import { NavigationTitanicModelManagerComponent } from './titanic/navigation-titanic-model-manager/navigation-titanic-model-manager.component';
import { NavigationTitanicPredictionsComponent } from './titanic/navigation-titanic-predictions/navigation-titanic-predictions.component';

const routes: Routes = [
  { path: '', redirectTo: '/titanic/dataset', pathMatch: 'full'},
  { path: 'titanic/dataset', component: NavigationTitanicPresentationComponent },
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

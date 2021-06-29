import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { PassengerDetailComponent } from './titanic/passenger-detail/passenger-detail.component';
import { PassengersComponent } from './titanic/passengers/passengers.component';
import { MessagesComponent } from './messages/messages.component';

import { AppRoutingModule } from './app-routing.module';

import { HttpClientModule } from '@angular/common/http';
import { PassengerSearchComponent } from './titanic/passenger-search/passenger-search.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { CreatePassengerFormComponent } from './titanic/create-passenger-form/create-passenger-form.component';
import { NavigationComponent } from './navigation/navigation.component';
import { ModelsComponent } from './model-manager/models/models.component'; 
import { ModelPredictionPassengerSelectionComponent } from './titanic/model-prediction-passenger-selection/model-prediction-passenger-selection.component';
import { ModelTrainingComponent } from './model-manager/model-training/model-training.component'; 
import { ModelPredictionComponent } from './titanic/model-prediction/model-prediction.component';
import { ModelValidationMetricsComponent } from './model-manager/model-validation-metrics/model-validation-metrics.component'; 
import { ModelPredictionDetailComponent } from './titanic/model-prediction-detail/model-prediction-detail.component';
import { ModelTrainingAlertNameTakenComponent } from './model-manager/model-training-alert-name-taken/model-training-alert-name-taken.component'; 
import { NavigationTitanicPresentationComponent } from './titanic/navigation-titanic-presentation/navigation-titanic-presentation.component';
import { NavigationTitanicModelManagerComponent } from './titanic/navigation-titanic-model-manager/navigation-titanic-model-manager.component';
import { NavigationTitanicPredictionsComponent } from './titanic/navigation-titanic-predictions/navigation-titanic-predictions.component';
import { OverviewTitanicModelManagerComponent } from './titanic/overview-titanic-model-manager/overview-titanic-model-manager.component'
import { OverviewTitanicPresentationComponent } from './titanic/overview-titanic-presentation/overview-titanic-presentation.component';
import { ModelValidationComponent } from './model-manager/model-validation/model-validation.component';

import { MatFormFieldModule } from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSelectModule } from '@angular/material/select';
import { MatRadioModule } from '@angular/material/radio';
import { MatCardModule } from '@angular/material/card';
import { LayoutModule } from '@angular/cdk/layout';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list'; 
import { MatAutocompleteModule } from '@angular/material/autocomplete'; 
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatTabsModule } from '@angular/material/tabs';
import { MatTableModule } from '@angular/material/table';
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner'; 
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { MatDialogModule } from '@angular/material/dialog';
import { MatCheckboxModule } from '@angular/material/checkbox'; 
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { MatChipsModule } from '@angular/material/chips';
import { MatSliderModule } from '@angular/material/slider';
import { OverviewTitanicPredictionsComponent } from './titanic/overview-titanic-predictions/overview-titanic-predictions.component';

@NgModule({
  declarations: [
    AppComponent,
    PassengersComponent,
    PassengerDetailComponent,
    MessagesComponent,
    PassengerSearchComponent,
    CreatePassengerFormComponent,
    NavigationComponent,
    ModelsComponent,
    ModelTrainingComponent,
    ModelPredictionComponent,
    NavigationTitanicModelManagerComponent,
    NavigationTitanicPredictionsComponent,
    ModelPredictionDetailComponent,
    ModelValidationComponent,
    ModelValidationMetricsComponent,
    ModelPredictionPassengerSelectionComponent,
    ModelTrainingAlertNameTakenComponent,
    NavigationTitanicPredictionsComponent,
    NavigationTitanicModelManagerComponent,
    NavigationTitanicPresentationComponent,
    OverviewTitanicModelManagerComponent,
    OverviewTitanicPresentationComponent,
    OverviewTitanicPredictionsComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatSelectModule,
    MatRadioModule,
    MatCardModule,
    ReactiveFormsModule,
    LayoutModule,
    MatToolbarModule,
    MatSidenavModule,
    MatIconModule,
    MatListModule,
    MatAutocompleteModule,
    MatPaginatorModule,
    MatTabsModule,
    MatTableModule,
    MatProgressSpinnerModule,
    MatButtonToggleModule,
    MatDialogModule,
    MatCheckboxModule,
    MatSlideToggleModule,
    MatChipsModule,
    MatSliderModule,
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { AppComponent } from './app.component';
import { AppRoutingModule } from './app-routing.module';

import { NavigationComponent } from './navigation/navigation.component';

import { ModelsComponent } from './model-manager/models/models.component'; 
import { ModelTrainingComponent } from './model-manager/model-training/model-training.component'; 
import { ModelTrainingAlertNameTakenComponent } from './model-manager/model-training-alert-name-taken/model-training-alert-name-taken.component'; 
import { ModelValidationComponent } from './model-manager/model-validation/model-validation.component';
import { ModelValidationMetricsComponent } from './model-manager/model-validation-metrics/model-validation-metrics.component'; 

import { PassengersComponent } from './titanic/passengers/passengers.component';
import { PassengerSearchComponent } from './titanic/passenger-search/passenger-search.component';
import { PassengerDetailComponent } from './titanic/passenger-detail/passenger-detail.component';
import { MessagesComponent } from './messages/messages.component';
import { NavigationTitanicPresentationComponent } from './titanic/navigation-titanic-presentation/navigation-titanic-presentation.component';
import { NavigationTitanicModelManagerComponent } from './titanic/navigation-titanic-model-manager/navigation-titanic-model-manager.component';
import { NavigationTitanicPredictionsComponent } from './titanic/navigation-titanic-predictions/navigation-titanic-predictions.component';
import { OverviewTitanicPresentationComponent } from './titanic/overview-titanic-presentation/overview-titanic-presentation.component';
import { OverviewTitanicModelManagerComponent } from './titanic/overview-titanic-model-manager/overview-titanic-model-manager.component'
import { OverviewTitanicPredictionsComponent } from './titanic/overview-titanic-predictions/overview-titanic-predictions.component';
import { ModelPredictionComponent } from './model-manager/model-prediction/model-prediction.component';
import { ModelPredictionPassengerSelectionComponent } from './titanic/model-prediction-passenger-selection/model-prediction-passenger-selection.component';
import { PassengerCreationComponent } from './titanic/passenger-creation/passenger-creation.component';
import { ModelPredictionPassengerDetailComponent } from './titanic/model-prediction-passenger-detail/model-prediction-passenger-detail.component';
import { NavigationNoshowPresentationComponent } from './noshow/navigation-noshow-presentation/navigation-noshow-presentation.component';
import { PatientsComponent } from './noshow/patients/patients.component';
import { PatientCreationComponent } from './noshow/patient-creation/patient-creation.component';
import { PatientDetailComponent } from './noshow/patient-detail/patient-detail.component';
import { PatientSearchComponent } from './noshow/patient-search/patient-search.component';
import { NavigationNoshowModelManagerComponent } from './noshow/navigation-noshow-model-manager/navigation-noshow-model-manager.component';
import { NavigationNoshowPredictionsComponent } from './noshow/navigation-noshow-predictions/navigation-noshow-predictions.component';
import { ModelPredictionPatientSelectionComponent } from './noshow/model-prediction-patient-selection/model-prediction-patient-selection.component';
import { ModelPredictionPatientDetailComponent } from './noshow/model-prediction-patient-detail/model-prediction-patient-detail.component';

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
import { NavigationTitanicMainComponent } from './titanic/navigation-titanic-main/navigation-titanic-main.component';
import { ModelPredictionPatientComponent } from './noshow/model-prediction-patient/model-prediction-patient.component';
import { ModelPredictionPassengerComponent } from './titanic/model-prediction-passenger/model-prediction-passenger.component';

@NgModule({
  declarations: [
    AppComponent,
    PassengersComponent,
    PassengerDetailComponent,
    MessagesComponent,
    PassengerSearchComponent,
    NavigationComponent,
    ModelsComponent,
    ModelTrainingComponent,
    ModelPredictionComponent,
    NavigationTitanicModelManagerComponent,
    NavigationTitanicPredictionsComponent,
    ModelValidationComponent,
    ModelValidationMetricsComponent,
    ModelPredictionPassengerSelectionComponent,
    ModelTrainingAlertNameTakenComponent,
    NavigationTitanicPredictionsComponent,
    NavigationTitanicModelManagerComponent,
    NavigationTitanicPresentationComponent,
    OverviewTitanicModelManagerComponent,
    OverviewTitanicPresentationComponent,
    OverviewTitanicPredictionsComponent,
    PassengerCreationComponent,
    ModelPredictionPassengerDetailComponent,
    NavigationNoshowPresentationComponent,
    PatientsComponent,
    PatientCreationComponent,
    PatientDetailComponent,
    PatientSearchComponent,
    NavigationNoshowModelManagerComponent,
    NavigationNoshowPredictionsComponent,
    ModelPredictionPatientSelectionComponent,
    ModelPredictionPatientDetailComponent,
    NavigationTitanicMainComponent,
    ModelPredictionPatientComponent,
    ModelPredictionPassengerComponent
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

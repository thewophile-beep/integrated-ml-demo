import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { PassengerDetailComponent } from './passenger-detail/passenger-detail.component';
import { PassengersComponent } from './passengers/passengers.component';
import { MessagesComponent } from './messages/messages.component';

import { AppRoutingModule } from './app-routing.module';

import { HttpClientModule } from '@angular/common/http';
import { PassengerSearchComponent } from './passenger-search/passenger-search.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import { MatFormFieldModule } from '@angular/material/form-field';
import { CreatePassengerFormComponent } from './create-passenger-form/create-passenger-form.component';
import { MatInputModule } from '@angular/material/input';
import { MatButtonModule } from '@angular/material/button';
import { MatSelectModule } from '@angular/material/select';
import { MatRadioModule } from '@angular/material/radio';
import { MatCardModule } from '@angular/material/card';
import { NavigationComponent } from './navigation/navigation.component';
import { LayoutModule } from '@angular/cdk/layout';
import { MatToolbarModule } from '@angular/material/toolbar';
import { MatSidenavModule } from '@angular/material/sidenav';
import { MatIconModule } from '@angular/material/icon';
import { MatListModule } from '@angular/material/list'; 
import { MatAutocompleteModule } from '@angular/material/autocomplete'; 
import { MatPaginatorModule } from '@angular/material/paginator';
import { MatTabsModule } from '@angular/material/tabs';
import { ModelsComponent } from './model-manager/models/models.component'; 
import { MatTableModule } from '@angular/material/table';
import { ModelTrainingComponent } from './model-manager/model-training/model-training.component'; 
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner'; 
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { ModelPredictionComponent } from './model-prediction/model-prediction.component';
import { NavigationDatasetPresentationComponent } from './navigation-dataset-presentation/navigation-dataset-presentation.component';
import { NavigationTitanicModelManagerComponent } from './navigation-titanic-model-manager/navigation-titanic-model-manager.component';
import { NavigationTitanicPredictionsComponent } from './navigation-titanic-predictions/navigation-titanic-predictions.component';
import { MatDialogModule } from '@angular/material/dialog';
import { OverviewModelManagerComponent } from './overview-model-manager/overview-model-manager.component';
import { OverviewDatasetPresentationComponent } from './overview-dataset-presentation/overview-dataset-presentation.component';
import { OverviewMakePredictionsComponent } from './overview-make-predictions/overview-make-predictions.component'; 
import { MatCheckboxModule } from '@angular/material/checkbox'; 
import { MatSlideToggleModule } from '@angular/material/slide-toggle';
import { ModelPredictionDetailComponent } from './model-prediction-detail/model-prediction-detail.component';
import { ModelValidationComponent } from './model-manager/model-validation/model-validation.component';
import { ModelValidationMetricsComponent } from './model-manager/model-validation-metrics/model-validation-metrics.component'; 
import { MatChipsModule } from '@angular/material/chips';
import { ModelPredictionPassengerSelectionComponent } from './model-prediction-passenger-selection/model-prediction-passenger-selection.component';
import { ModelTrainingAlertNameTakenComponent } from './model-manager/model-training-alert-name-taken/model-training-alert-name-taken.component'; 
import { MatSliderModule } from '@angular/material/slider';

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
    NavigationDatasetPresentationComponent,
    NavigationTitanicModelManagerComponent,
    NavigationTitanicPredictionsComponent,
    OverviewModelManagerComponent,
    OverviewDatasetPresentationComponent,
    OverviewMakePredictionsComponent,
    ModelPredictionDetailComponent,
    ModelValidationComponent,
    ModelValidationMetricsComponent,
    ModelPredictionPassengerSelectionComponent,
    ModelTrainingAlertNameTakenComponent,
    NavigationTitanicPredictionsComponent,
    NavigationTitanicModelManagerComponent,
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

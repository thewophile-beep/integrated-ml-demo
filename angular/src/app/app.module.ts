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
import { ExplicationProjetComponent } from './explication-projet/explication-projet.component';
import { ModelsComponent } from './models/models.component'; 
import { MatTableModule } from '@angular/material/table';
import { ModelTrainingComponent } from './model-training/model-training.component'; 
import { MatProgressSpinnerModule } from '@angular/material/progress-spinner'; 
import { MatButtonToggleModule } from '@angular/material/button-toggle';
import { ModelPredictionComponent } from './model-prediction/model-prediction.component';
import { NavigationDatasetPresentationComponent } from './navigation-dataset-presentation/navigation-dataset-presentation.component';
import { NavigationModelManagerComponent } from './navigation-model-manager/navigation-model-manager.component';
import { NavigationMakePredictionsComponent } from './navigation-make-predictions/navigation-make-predictions.component';
import { MatDialogModule } from '@angular/material/dialog'; 
@NgModule({
  declarations: [
    AppComponent,
    PassengersComponent,
    PassengerDetailComponent,
    MessagesComponent,
    PassengerSearchComponent,
    CreatePassengerFormComponent,
    NavigationComponent,
    ExplicationProjetComponent,
    ModelsComponent,
    ModelTrainingComponent,
    ModelPredictionComponent,
    NavigationDatasetPresentationComponent,
    NavigationModelManagerComponent,
    NavigationMakePredictionsComponent,
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
    MatDialogModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { DashboardComponent } from './dashboard/dashboard.component';
import { PassengerDetailComponent } from './passenger-detail/passenger-detail.component';
import { PassengersComponent } from './passengers/passengers.component';
import { MessagesComponent } from './messages/messages.component';

import { AppRoutingModule } from './app-routing.module';

import { HttpClientModule } from '@angular/common/http';
import { PassengerSearchComponent } from './passenger-search/passenger-search.component';
import { PassengerCreationComponent } from './passenger-creation/passenger-creation.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';

import {MatFormFieldModule} from '@angular/material/form-field'; 
@NgModule({
  declarations: [
    AppComponent,
    PassengersComponent,
    PassengerDetailComponent,
    MessagesComponent,
    DashboardComponent,
    PassengerSearchComponent,
    PassengerCreationComponent,
  ],
  imports: [
    BrowserModule,
    FormsModule,
    AppRoutingModule,
    HttpClientModule,
    BrowserAnimationsModule,
    MatFormFieldModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

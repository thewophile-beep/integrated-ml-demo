import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

import { Passenger } from './passenger';
import { MessageService } from './message.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})

export class PassengerService {

  private PassengersUrl = 'http://localhost:52775/api/titanic/passengers';  // URL to web api

  httpOptions = {
    headers: new HttpHeaders({ 'Content-Type': 'application/json',
    'Authorization': 'Basic '+ btoa('SuperUser:SYS') })
  };
  
  /**
   * Handle Http operation that failed.
   * Let the app continue.
   * @param operation - name of the operation that failed
   * @param result - optional value to return as the observable result
   */
  private handleError<T>(operation = 'operation', result?: T) {
    return (error: any): Observable<T> => {

      // TODO: send the error to remote logging infrastructure
      console.error(error); // log to console instead

      // TODO: better job of transforming error for user consumption
      this.log(`${operation} failed: ${error.message}`);

      // Let the app keep running by returning an empty result.
      return of(result as T);
    };
  }
  
  private log(message: string) {
    this.messageService.add(`PassengerService: ${message}`);
  }
  
  constructor(
    private http: HttpClient,
    private messageService: MessageService) { }


  /** GET Passengers from the server */
  getAllPassengers(): Observable<Passenger[]> {
    return this.http.get<Passenger[]>(this.PassengersUrl)
      .pipe(
        tap(_ => this.log('fetched Passengers')),
        catchError(this.handleError<Passenger[]>('getPassengers', []))
      );
  }

  /** GET Passenger by id. Will 404 if id not found */
  getPassenger(id: number): Observable<Passenger> {
    const url = `${this.PassengersUrl}/${id}`;
    return this.http.get<Passenger>(url)
      .pipe(
        tap(_ => this.log(`fetched Passenger id=${id}`)),
        catchError(this.handleError<Passenger>(`getPassenger id=${id}`))
      );
  }

  /** PUT: update the Passenger on the server */
  updatePassenger(id: number, Passenger: Passenger): Observable<any> {
    return this.http.put(`${this.PassengersUrl}/${id}`, Passenger, this.httpOptions).pipe(
      tap(_ => this.log(`updated Passenger id=${Passenger.Id}`)),
      catchError(this.handleError<any>('updatePassenger'))
    );
  }

  /** POST: add a new Passenger to the server */
  createPassenger(Passenger: Passenger): Observable<Passenger> {
    return this.http.post<Passenger>(this.PassengersUrl, Passenger, this.httpOptions).pipe(
      tap((newPassenger: Passenger) => this.log(`added Passenger w/ id=${newPassenger.Id}`)),
      catchError(this.handleError<Passenger>('addPassenger'))
    );
  }

  /** DELETE: delete the Passenger from the server */
  deletePassenger(id: number): Observable<Passenger> {
    const url = `${this.PassengersUrl}/${id}`;

    return this.http.delete<Passenger>(url, this.httpOptions).pipe(
      tap(_ => this.log(`deleted Passenger id=${id}`)),
      catchError(this.handleError<Passenger>('deletePassenger'))
    );
  }

  /* GET Passengers whose name contains search term */
  searchPassengers(term: string): Observable<Passenger[]> {
    if (!term.trim()) {
      // if not search term, return empty Passenger array.
      return of([]);
    }
    return this.http.get<Passenger[]>(`${this.PassengersUrl}/?name=${term}`).pipe(
      tap(x => x.length ?
        this.log(`found Passengers matching "${term}"`) :
        this.log(`no Passengers matching "${term}"`)),
      catchError(this.handleError<Passenger[]>('searchPassengers', []))
    );
  }
}

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
    headers: new HttpHeaders({ 'Content-Type': 'application/json' })
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
    // this.messageService.add(`PassengerService: ${message}`);
  }
  
  constructor(
    private http: HttpClient,
    private messageService: MessageService) { }


  /** GET Passengers from the server */
  getAllPassengers(currPage: number, pageSize: number): Observable<any> {
    const url = `${this.PassengersUrl}?currPage=${currPage + 1}&pageSize=${pageSize}`
    return this.http.get<any>(url)
      .pipe(
        tap(_ => this.log('fetched Passengers')),
        catchError(this.handleError<any>('getPassengers', []))
      );
  }

  /* GET Passengers whose name contains search term */
  searchPassengers(term: string): Observable<Passenger[]> {
    if (!term.trim() || term.length < 3) {
      // if not search term, return empty Passenger array.
      return of([]);
    }
    return this.http.get<any>(`${this.PassengersUrl}?name=${term}`).pipe(
      map(res => res.passengers),
      tap(x => x.length ?
        this.log(`found Passengers matching "${term}"`) :
        this.log(`no Passengers matching "${term}"`)),
      catchError(this.handleError<any>('searchPassengers', []))
    );
  }
  
  /** POST: add a new Passenger to the server */
  createPassenger(Passenger: Passenger): Observable<any> {
    return this.http.post<any>(this.PassengersUrl, Passenger, this.httpOptions).pipe(
      tap(response => this.log(`added Passenger w/ id=${response.passengerId}`)),
      catchError(this.handleError<any>('createPassenger'))
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
    return this.http.put(`${this.PassengersUrl}/${id}`, Passenger, this.httpOptions)
      .pipe(
        tap(_ => this.log(`updated Passenger id=${id}`)),
        catchError(this.handleError<any>('updatePassenger'))
      );
  }

  /** DELETE: delete the Passenger from the server */
  deletePassenger(id: number): Observable<Passenger> {
    const url = `${this.PassengersUrl}/${id}`;

    return this.http.delete<Passenger>(url, this.httpOptions)
      .pipe(
        tap(_ => this.log(`deleted Passenger id=${id}`)),
        catchError(this.handleError<Passenger>('deletePassenger'))
      );
  }

}

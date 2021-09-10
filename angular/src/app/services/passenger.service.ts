import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

import { Passenger } from '../definitions/passenger';
import { MessageService } from './message.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})

export class PassengerService {

  private currentUrl = localStorage.getItem('url')
  private PassengersUrl = this.currentUrl + 'passengers';

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
    this.messageService.add(`PassengerService: ${message}`);
  }

  private logMessage(message: string,verbose:boolean) {
    this.messageService.addMessage(message,verbose);
  }
  
  constructor(
    private http: HttpClient,
    private messageService: MessageService) { }


  /** GET Passengers from the server */
  getAllPassengers(currPage: number, pageSize: number): Observable<any> {
    const url = `${this.PassengersUrl}?currPage=${currPage + 1}&pageSize=${pageSize}`
    return this.http.get<any>(url)
      .pipe(
        tap(response => this.logMessage(response.query,false)),
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
      tap(response => this.logMessage(response.query,false)),
      map(res => res.passengers),
      catchError(this.handleError<any>('searchPassengers', []))
    );
  }
  
  /** POST: add a new Passenger to the server */
  createPassenger(Passenger: Passenger): Observable<any> {
    return this.http.post<any>(this.PassengersUrl, Passenger, this.httpOptions).pipe(
      tap(response => this.logMessage(response.query,false)),
      catchError(this.handleError<any>('createPassenger'))
    );
  }

  /** GET Passenger by id. Will 404 if id not found */
  getPassenger(id: number): Observable<Passenger> {
    const url = `${this.PassengersUrl}/${id}`;
    return this.http.get<any>(url).pipe(
      tap(response => this.logMessage(response.query,false)),
      map(res => res.passenger),
      catchError(this.handleError<any>(`getPassenger id=${id}`))
    );
  }

  /** PUT: update the Passenger on the server */
  updatePassenger(id: number, Passenger: Passenger): Observable<any> {
    return this.http.put<any>(`${this.PassengersUrl}/${id}`, Passenger, this.httpOptions).pipe(
      tap(response => this.logMessage(response.query,false)),
      catchError(this.handleError<any>('updatePassenger'))
    );
  }

  /** DELETE: delete the Passenger from the server */
  deletePassenger(id: number): Observable<any> {
    const url = `${this.PassengersUrl}/${id}`;

    return this.http.delete<any>(url, this.httpOptions).pipe(
      tap(response => this.logMessage(response.query,false)),
      catchError(this.handleError<any>('deletePassenger'))
    );
  }

}

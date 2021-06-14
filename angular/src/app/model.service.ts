import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

import { ML_MODEL } from './ML_MODEL';
import { MessageService } from './message.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class ModelService {

  private ModelsUrl = 'http://localhost:52775/api/titanic/ml';

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

  constructor(private http: HttpClient, private messageService: MessageService) { }

  /** GET Models from the server */
  getAllModels(): Observable<ML_MODEL[]> {
    const url = `${this.ModelsUrl}/models`;
    return this.http.get<ML_MODEL[]>(url)
      .pipe(
        tap(_ => this.log('fetched Models')),
        catchError(this.handleError<ML_MODEL[]>('getModels', []))
      );
  }

  deleteModel(name: string): Observable<ML_MODEL> {
    const url = `${this.ModelsUrl}/models?modelName=${name}`;

    return this.http.delete<ML_MODEL>(url, this.httpOptions).pipe(
      tap(_ => this.log(`deleted Model ${name}`)),
      catchError(this.handleError<ML_MODEL>('deletePassenger'))
    );
  }

    /** POST: add a new Passenger to the server */
    createModel(modelName: string, predicting: string): Observable<ML_MODEL> {
      const url = this.ModelsUrl + "/models?modelName=" + modelName + "&predicting=" + predicting
      return this.http.post<ML_MODEL>(url, this.httpOptions).pipe(
        tap(_ => this.log(`added Model w/ name=${modelName}`)),
        catchError(this.handleError<ML_MODEL>('createModel'))
      );
    }
}

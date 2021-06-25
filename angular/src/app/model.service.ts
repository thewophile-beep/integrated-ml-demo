import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, tap } from 'rxjs/operators';

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
    this.messageService.add(`SQL query: ${message}`);
  }

  constructor(private http: HttpClient, private messageService: MessageService) { }

  /** GET Models from the server */
  getAllModels(): Observable<any> {
    const url = this.ModelsUrl + "/models";
    return this.http.get<any>(url).pipe(
        // tap(response => this.log(response.query)),
        catchError(this.handleError<any>('getModels', []))
      );
  }

    /** POST: add a new Passenger to the server */
  createModel(modelName: string, predictValue: string, fromTable: string, withVariables: string[]): Observable<any> {
    const url = this.ModelsUrl + "/models";
    if (withVariables.length > 0) {
    const payloadBody = {
        modelName: modelName,
        predictValue: predictValue,
        fromTable: fromTable,
        withVariables: withVariables
      }
      return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
        tap(response => this.log(response.query)),
        catchError(this.handleError<any>('createModel'))
      );
    } else {
      const payloadBody = {
        modelName: modelName,
        predictValue: predictValue,
        fromTable: fromTable,
      }
      return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
        tap(response => this.log(response.query)),
        catchError(this.handleError<any>('createModel'))
      );
    }
  }
 
  deleteModel(name: string): Observable<any> {
    const url = `${this.ModelsUrl}/models?modelName=${name}`;

    return this.http.delete<any>(url, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('deletePassenger'))
    );
  }

  getTrainingRuns(): Observable<any> {
    const url = this.ModelsUrl + "/trainings";
    return this.http.get<any>(url).pipe(
      // tap(response => this.log(response.query)),
      catchError(this.handleError<any>('getTrainingRuns', []))
    );
  }

  trainModel(modelName: string, trainingName: string): Observable<any> {
    const url = this.ModelsUrl + "/trainings";
    const payloadBody = {
      modelName: modelName,
      trainingName: trainingName
    }
    return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('trainModel'))
    );
  }
  
  getStateTrainingRun(modelName: string, trainingName: string): Observable<any> {
    const url = this.ModelsUrl + "/trainings/states?modelName=" + modelName + "&trainingName=" + trainingName ;
    return this.http.get<any>(url, this.httpOptions).pipe(
      catchError(this.handleError<any>('getStateTrainingRun'))
    );
  }

  changeConfiguration(config: string): Observable<any> {
    const url = this.ModelsUrl + "/trainings/configurations";
    const payloadBody = {
      configName: config
    }
    return this.http.put<any>(url, payloadBody, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('changeConfiguration'))
    )
  }
  
  getTrainedModels(): Observable<any> {
    const url = this.ModelsUrl + "/predictions/models";
    return this.http.get<any>(url).pipe(
      // tap(response => this.log(response.query)),
      catchError(this.handleError<any>('getTrainedModels', []))
    );
  }


  predict(model: string, trainedModelName: string, passenger: string): Observable<any> {
    const url = `${this.ModelsUrl}/predictions?model=${model}&trainedModel=${trainedModelName}&passenger=${passenger}`;
    return this.http.get<any>(url, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('predict'))
    )
  }

  getValidationRuns(): Observable<any> {
    const url = this.ModelsUrl + "/validations";
    return this.http.get<any>(url).pipe(
      // tap(response => this.log(response.query)),
      catchError(this.handleError<any>('getValidationRuns', []))
    );
  }

  validateModel(modelName: string, validationName: string, trainedModelName: string, fromTable: string): Observable<any> {
    const url = this.ModelsUrl + "/validations";
    const payloadBody = {
      modelName: modelName,
      validationName: validationName,
      trainedModelName: trainedModelName,
      fromTable: fromTable
    }
    return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('validateModel'))
    );
  }

  getMetrics(modelName: string, validationName: string): Observable<any> {
    const url = this.ModelsUrl + "/validations/metrics?modelName=" + modelName + "&validationName=" + validationName;
    return this.http.get<any>(url).pipe(
      // tap(response => this.log(response.query)),
      catchError(this.handleError<any>('getMetrics', []))
    );
  }

  probability(model: string, trainedModelName: string, labelValue: string, passenger: string): Observable<any> {
    const url = `${this.ModelsUrl}/predictions/probabilities?model=${model}&trainedModel=${trainedModelName}&labelValue=${labelValue}&passenger=${passenger}`;
    return this.http.get<any>(url, this.httpOptions).pipe(
      tap(probability => this.log(probability.query)),
      catchError(this.handleError<any>('probability'))
    )
  }
}

import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

import { mlModel } from './mlModel';
import { mlTrainingModel } from './mlTrainingModel';
import { mlTrainedModel } from './mlTrainedModel';
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
    this.messageService.add(`ModelService: ${message}`);
  }

  constructor(private http: HttpClient, private messageService: MessageService) { }

  /** GET Models from the server */
  getAllModels(): Observable<mlModel[]> {
    const url = this.ModelsUrl + "/models";
    return this.http.get<mlModel[]>(url).pipe(
        tap(_ => this.log('fetched Models')),
        catchError(this.handleError<mlModel[]>('getModels', []))
      );
  }

    /** POST: add a new Passenger to the server */
  createModel(modelName: string, predictValue: string, tableName: string, withVariables: string[]): Observable<mlModel> {
    const url = this.ModelsUrl + "/models";
    const payloadBody = {
      modelName: modelName,
      predictValue: predictValue,
      tableName: tableName
    }
    return this.http.post<mlModel>(url, payloadBody, this.httpOptions).pipe(
      tap(_ => this.log(`added Model w/ name=${modelName}`)),
      catchError(this.handleError<mlModel>('createModel'))
    );
  }
 
  deleteModel(name: string): Observable<mlModel> {
    const url = `${this.ModelsUrl}/models?modelName=${name}`;

    return this.http.delete<mlModel>(url, this.httpOptions).pipe(
      tap(_ => this.log(`deleted Model ${name}`)),
      catchError(this.handleError<mlModel>('deletePassenger'))
    );
  }

  getTrainingRuns(): Observable<mlTrainingModel[]> {
    const url = this.ModelsUrl + "/trainings";
    return this.http.get<mlTrainingModel[]>(url).pipe(
      tap(_ => this.log('fetched Training Runs')),
      catchError(this.handleError<mlTrainingModel[]>('getTrainingRuns', []))
    );
  }

  trainModel(modelName: string, trainingName: string): Observable<any> {
    const url = this.ModelsUrl + "/trainings";
    const payloadBody = {
      modelName: modelName,
      trainingName: trainingName
    }
    return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
      tap(_ => this.log(`trained model ${modelName} as ${trainingName}`)),
      catchError(this.handleError<any>('trainModel'))
    );
  }
  
  changeConfiguration(config: string): Observable<any> {
    const url = this.ModelsUrl + "/trainings/configurations";
    return this.http.put<any>(url, config, this.httpOptions).pipe(
      tap(_ => this.log(`changed configuration to ${config}`)),
      catchError(this.handleError<any>('changeConfiguration'))
    )
  }
  
  getTrainedModels(): Observable<mlTrainedModel[]> {
    const url = this.ModelsUrl + "/predictions/models";
    return this.http.get<mlTrainedModel[]>(url).pipe(
      tap(_ => this.log('fetched trained models')),
      catchError(this.handleError<mlTrainedModel[]>('getTrainedModels', []))
    );
  }


  predict(model: string, trainedModelName: string, passenger: string): Observable<any> {
    const url = `${this.ModelsUrl}/predictions?model=${model}&trainedModel=${trainedModelName}&passenger=${passenger}`;
    return this.http.get<any>(url, this.httpOptions).pipe(
      tap(predicted => this.log(`Predicted Value = ${predicted.predictedValue}`)),
      catchError(this.handleError<any>('predict'))
    )
  }
}

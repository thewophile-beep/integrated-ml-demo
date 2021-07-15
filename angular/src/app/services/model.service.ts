import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { catchError, map, tap } from 'rxjs/operators';

import { MessageService } from './message.service';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { environment } from 'src/environments/environment';
import { mlValidationRun } from '../definitions/mlValidationRun';
import { mlTrainedModel } from '../definitions/mlTrainedModel';
import { mlModel } from '../definitions/mlModel';
import { mlTrainingModel } from '../definitions/mlTrainingModel';

@Injectable({
  providedIn: 'root'
})
export class ModelService {

  private ModelsUrl = environment.url + 'ml';

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

  // GET models from the server
  getAllModels(): Observable<mlModel[]> {
    const url = this.ModelsUrl + "/models";
    return this.http.get<any>(url).pipe(
        tap(response => this.log(response.query)),
        map(res => res.models),
        catchError(this.handleError<any>('getModels', []))
      );
  }

  // POST a new model
  createModel(modelName: string, predictValue: string, fromTable: string, withVariables: string[]) {
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
 
  // DELETE model
  deleteModel(name: string) {
    const url = `${this.ModelsUrl}/models?modelName=${name}`;

    return this.http.delete<any>(url, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('deletePassenger'))
    );
  }

  // GET training runs
  getTrainingRuns(): Observable<mlTrainingModel[]> {
    const url = this.ModelsUrl + "/trainings";
    return this.http.get<any>(url).pipe(
      tap(response => this.log(response.query)),
      map(res => res.trainingRuns),
      catchError(this.handleError<any>('getTrainingRuns', []))
    );
  }

  // POST new training run
  trainModel(modelName: string, trainingName: string, fromTable: string) {
    const url = this.ModelsUrl + "/trainings";
    const payloadBody = {
      modelName: modelName,
      trainingName: trainingName,
      fromTable: fromTable
    }
    return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('trainModel'))
    );
  }

  // GET state of training run
  getStateTrainingRun(modelName: string, trainingName: string): Observable<string> {
    const url = this.ModelsUrl + "/trainings/states?modelName=" + modelName + "&trainingName=" + trainingName ;
    return this.http.get<any>(url, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      map(res => res.state),
      catchError(this.handleError<any>('getStateTrainingRun'))
    );
  }

  // GET all configurations and defatul configuration
  getAllConfigurations(): Observable<any> {
    const url = this.ModelsUrl + "/trainings/configurations";
    return this.http.get<any>(url).pipe(
      catchError(this.handleError<any>('getAllConfigurations'))
    )
  }

  // PUT configuration
  changeConfiguration(config: string) {
    const url = this.ModelsUrl + "/trainings/configurations";
    const payloadBody = {
      configName: config
    }
    return this.http.put<any>(url, payloadBody, this.httpOptions).pipe(
      catchError(this.handleError<any>('changeConfiguration'))
    )
  }
  
  // GET trained models
  getTrainedModels(): Observable<mlTrainedModel[]> {
    const url = this.ModelsUrl + "/predictions/models";
    return this.http.get<any>(url).pipe(
      tap(response => this.log(response.query)),
      map(res => res.models),
      catchError(this.handleError<any>('getTrainedModels', []))
    );
  }

  // GET prediction
  predict(model: string, trainedModelName: string, id: string, fromTable: string): Observable<string> {
    const url = `${this.ModelsUrl}/predictions?model=${model}&trainedModel=${trainedModelName}&id=${id}&fromTable=${fromTable}`;
    return this.http.get<any>(url, this.httpOptions).pipe(
      tap(response => this.log(response.query)),
      map(res => res.predictedValue),
      catchError(this.handleError<any>('predict'))
    )
  }

  // GET validation runs
  getValidationRuns(): Observable<mlValidationRun[]> {
    const url = this.ModelsUrl + "/validations";
    return this.http.get<any>(url).pipe(
      tap(response => this.log(response.query)),
      map(res => res.validationRuns),
      catchError(this.handleError<any>('getValidationRuns', []))
    );
  }

  // POST new validation
  validateModel(modelName: string, validationName: string, trainedModelName: string, fromTable: string) {
    const url = this.ModelsUrl + "/validations";
    if (validationName.length > 0){
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
    } else {
      const payloadBody = {
        modelName: modelName,
        trainedModelName: trainedModelName,
        fromTable: fromTable
      }
      return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
        tap(response => this.log(response.query)),
        catchError(this.handleError<any>('validateModel'))
      );
    }
  }

  // GET metrics
  getMetrics(modelName: string, validationName: string): Observable<any[]> {
    const url = this.ModelsUrl + "/validations/metrics?modelName=" + modelName + "&validationName=" + validationName;
    return this.http.get<any>(url).pipe(
      tap(response => this.log(response.query)),
      map(res => res.metrics),
      catchError(this.handleError<any>('getMetrics', []))
    );
  }

  // GET probability
  probability(model: string, trainedModelName: string, labelValue: string, id: string, fromTable: string): Observable<string> {
    const url = `${this.ModelsUrl}/predictions/probabilities?model=${model}&trainedModel=${trainedModelName}&labelValue=${labelValue}&id=${id}&fromTable=${fromTable}`;
    return this.http.get<any>(url).pipe(
      tap(probability => this.log(probability.query)),
      map(res => res.probability),
      catchError(this.handleError<any>('probability'))
    )
  }

  getTableSize(table: string): Observable<string> {
    const url = this.ModelsUrl + "/tablesize?table=" + table;
    return this.http.get<any>(url).pipe(
      map(res => res.total),
      catchError(this.handleError<any>('getTableSize'))
    )
  }

  purgeModel(modelName: string) {
    const url = this.ModelsUrl + "/models/purge?modelName=" + modelName;
    return this.http.delete<any>(url).pipe(
      tap(response => this.log(response.query)),
      catchError(this.handleError<any>('purgeModel'))
    )
  }

  getLogTrainingRun(trainingName: string): Observable<string> {
    const url = this.ModelsUrl + "/trainings/logs?trainingName=" + trainingName;
    return this.http.get<any>(url).pipe(
      tap(response => this.log(response.query)),
      map(res => res.log),
      catchError(this.handleError<any>('getLogTrainingRun'))
    )
  }

  createDRConfiguration(chosenUrl: string, apiToken: string) {
    const url = this.ModelsUrl + "/trainings/configurations/datarobot";
    const payloadBody = {
      url: chosenUrl,
      apiToken: apiToken,
    }
    return this.http.post<any>(url, payloadBody, this.httpOptions).pipe(
      tap(res => this.log(res.query)),
      catchError(this.handleError<any>('createDRConfiguration'))
    )
  }
  
  alterDRConfiguration(chosenUrl: string, apiToken: string) {
    const url = this.ModelsUrl + "/trainings/configurations/datarobot";
    const payloadBody = {
      url: chosenUrl,
      apiToken: apiToken,
    }
    return this.http.put<any>(url, payloadBody, this.httpOptions).pipe(
      tap(res => this.log(res.query)),
      catchError(this.handleError<any>('alterDRConfiguration'))
    )
  }
}

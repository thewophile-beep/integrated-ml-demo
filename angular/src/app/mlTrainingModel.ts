export interface mlTrainingModel {
    modelName: string;
    trainingRunName: string;
    provider: string;
    startTimestamp: string;
    completedTimestamp: string;
    trainingDuration: string;
    runStatus: string;
    statusCode: string;
    log: string;
    settings: string;
    mlConfigurationName: string;
    trainingRunQuery: string;
}
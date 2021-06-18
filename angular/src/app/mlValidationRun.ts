export interface mlValidationRun {
    modelName: string
    trainedModelName: string
    validationRunName: string
    startTimestamp: string
    completedTimestamp: string
    validationDuration: string
    runStatus: string
    statusCode: string
    log: string
    settings: string
    validationRunQuery: string
}
export interface mlModel {
    modelName: string;
    description: string;
    predictingColumnName: string;
    predictingColumnType: string;
    withColumns: string;
    createTimestamp: string;
    defaultTrainedModelName: string;
    defaultSettings: string;
    defaultTrainingQuery: string;
}
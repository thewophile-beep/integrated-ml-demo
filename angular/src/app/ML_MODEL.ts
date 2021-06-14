export interface ML_MODEL {
    MODEL_NAME: string;
    DESCRIPTION: string;
    PREDICTING_COLUMN_NAME: string;
    PREDICTING_COLUMN_TYPE: string;
    WITH_COLUMNS: string;
    CREATE_TIMESTAMP: string;
    DEFAULT_TRAINED_MODEL_NAME: string;
    DEFAULT_SETTINGS: string;
    DEFAULT_TRAINING_QUERY: string;
}
export interface ML_TRAINING_RUN {
    MODEL_NAME: string;
    TRAINING_RUN_NAME: string;
    PROVIDER: string;
    START_TIMESTAMP: string;
    COMPLETED_TIMESTAMP: string;
    TRAINING_DURATION: string;
    RUN_STATUS: string;
    STATUS_CODE: string;
    LOG: string;
    SETTINGS: string;
    ML_CONFIGURATION_NAME: string;
    TRAINING_RUN_QUERY: string;
}
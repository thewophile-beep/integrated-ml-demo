Class IntegratedML.REST.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger": "2.0",
  "info": {
    "title": "InterSystems IRIS REST API for Integrated ML Demo",
    "description": "Rest API for the Integrated ML Demo",
    "version": "0.2",
    "contact": {
      "email": "theophile.thierry@intersystems.com"
    },
    "license": {
      "name": " 2.0",
      "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
    }
  },
  "host": "localhost:52775",
  "basePath": "/api/integratedML",
  "schemes": [
    "http",
    "https"
  ],
  "securityDefinitions": {
    "basicAuth": {
      "type": "basic"
    }
  },
  "security": [
    {
      "basicAuth": []
    }
  ],
  "paths": {
    "/passengers": {
      "get": {
        "description": "Retreive the total number of Passengers THEN the Passengers from currPage\\*(pageSize-1) to currPage\\*pageSize. Search by name possible too.",
        "summary": "Get passengers with pagination and search by name possible",
        "parameters": [
          {
            "in": "query",
            "name": "currPage",
            "type": "number",
            "description": "The current page at which the client is"
          },
          {
            "in": "query",
            "name": "pageSize",
            "type": "number",
            "description": "The number of passengers per page"
          },
          {
            "in": "query",
            "name": "name",
            "type": "string",
            "description": "Search passenger by name"
          }
        ],
        "operationId": "getAllPassengers",
        "x-ISC_ServiceMethod": "getAllPassengers",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "total": {
                  "type": "number"
                },
                "passengers": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/passenger"
                  }
                }
              }
            }
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "post": {
        "description": "Create a new passenger to put in the table",
        "summary": "Create a passenger",
        "operationId": "createPassenger",
        "x-ISC_ServiceMethod": "createPassenger",
        "parameters": [
          {
            "name": "payloadBody",
            "in": "body",
            "description": "Request body contents",
            "required": false,
            "schema": {
              "$ref": "#/definitions/passenger"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "passengerId": {
                  "type": "integer"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/passengers/{id}": {
      "get": {
        "description": "Return the saved informations of passenger n°{id}",
        "summary": "Get passenger n°{id} info",
        "operationId": "getPassenger",
        "x-ISC_ServiceMethod": "getPassenger",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "$ref": "#/definitions/passenger"
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "put": {
        "description": "Update already existing passenger {id} with information in the payload",
        "summary": "Update passenger {id} info",
        "operationId": "updatePassenger",
        "x-ISC_ServiceMethod": "updatePassenger",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer"
          },
          {
            "name": "payloadBody",
            "in": "body",
            "description": "Request body contents",
            "required": false,
            "schema": {
              "$ref": "#/definitions/passenger"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)"
          },
          "204": {
            "description": "(Not Found)"
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "delete": {
        "description": "Delete existing passenger with {id}",
        "summary": "Delete passenger {id}",
        "operationId": "deletePassenger",
        "x-ISC_ServiceMethod": "deletePassenger",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)"
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/patients": {
      "get": {
        "description": "Retreive the total number of Patients THEN the Patients from currPage\\*(pageSize-1) to currPage\\*pageSize. Search by name possible too.",
        "summary": "Get patients with pagination and search by name possible",
        "parameters": [
          {
            "in": "query",
            "name": "currPage",
            "type": "number",
            "description": "The current page at which the client is"
          },
          {
            "in": "query",
            "name": "pageSize",
            "type": "number",
            "description": "The number of patients per page"
          },
          {
            "in": "query",
            "name": "id",
            "type": "string",
            "description": "Search patient by id"
          }
        ],
        "operationId": "getAllPatients",
        "x-ISC_ServiceMethod": "getAllPatients",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "total": {
                  "type": "number"
                },
                "patients": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/patient"
                  }
                }
              }
            }
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "post": {
        "description": "Create a new patient to put in the table",
        "summary": "Create a patient",
        "operationId": "createPatient",
        "x-ISC_ServiceMethod": "createPatient",
        "parameters": [
          {
            "name": "payloadBody",
            "in": "body",
            "description": "Request body contents",
            "required": false,
            "schema": {
              "$ref": "#/definitions/patient"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "patientId": {
                  "type": "integer"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/patients/{id}": {
      "get": {
        "description": "Return the saved informations of patient n°{id}",
        "summary": "Get patient n°{id} info",
        "operationId": "getPatient",
        "x-ISC_ServiceMethod": "getPatient",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "$ref": "#/definitions/patient"
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "put": {
        "description": "Update already existing patient {id} with information in the payload",
        "summary": "Update patient {id} info",
        "operationId": "updatePatient",
        "x-ISC_ServiceMethod": "updatePatient",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer"
          },
          {
            "name": "payloadBody",
            "in": "body",
            "description": "Request body contents",
            "required": false,
            "schema": {
              "$ref": "#/definitions/patient"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)"
          },
          "204": {
            "description": "(Not Found)"
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "delete": {
        "description": "Delete existing patient with {id}",
        "summary": "Delete patient {id}",
        "operationId": "deletePatient",
        "x-ISC_ServiceMethod": "deletePatient",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "integer"
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)"
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/tablesize": {
      "get": {
        "description": "Retreive the total number of objects in a table",
        "summary": "Get nb of objects in table",
        "parameters": [
          {
            "in": "query",
            "name": "table",
            "type": "string",
            "description": "The table we need the max size from"
          }
        ],
        "operationId": "getTableSize",
        "x-ISC_ServiceMethod": "getTableSize",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "total": {
                  "type": "number"
                }
              }
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/models": {
      "get": {
        "description": "Retreive all created models",
        "summary": "Get all models",
        "operationId": "getAllModels",
        "x-ISC_ServiceMethod": "getAllModels",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "models": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/mlModel"
                  }
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "post": {
        "parameters": [
          {
            "in": "body",
            "name": "createInfo",
            "required": true,
            "description": "Information about model creation",
            "schema": {
              "type": "object",
              "properties": {
                "modelName": {
                  "type": "string"
                },
                "predictValue": {
                  "type": "string"
                },
                "fromTable": {
                  "type": "string"
                },
                "withVariables": {
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                }
              }
            }
          }
        ],
        "description": "Create a model modelName that predicts predictValue from the table tableName using the variables in the array withVariables",
        "summary": "Create a Model",
        "operationId": "createModel",
        "x-ISC_ServiceMethod": "createModel",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "delete": {
        "parameters": [
          {
            "in": "query",
            "name": "modelName",
            "required": true,
            "description": "Name of the model to be deleted",
            "type": "string"
          }
        ],
        "description": "Delete a model (along with all of its trained runs)",
        "summary": "Delete a model",
        "operationId": "deleteModel",
        "x-ISC_ServiceMethod": "deleteModel",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/models/purge": {
      "delete": {
        "description": "Purge runs from a model",
        "summary": "Purge runs from model",
        "parameters": [
          {
            "name": "modelName",
            "in": "query",
            "required": true,
            "type": "string"
          }
        ],
        "operationId": "purgeModel",
        "x-ISC_ServiceMethod": "purgeModel",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/trainings": {
      "get": {
        "description": "Get all training runs",
        "summary": "Get all training runs",
        "operationId": "getTrainingRuns",
        "x-ISC_ServiceMethod": "getTrainingRuns",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "trainingRuns": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/mlTrainingRun"
                  }
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "post": {
        "parameters": [
          {
            "in": "body",
            "name": "trainingInfo",
            "required": true,
            "description": "Training informations",
            "schema": {
              "type": "object",
              "properties": {
                "modelName": {
                  "type": "string"
                },
                "trainingName": {
                  "type": "string"
                },
                "fromTable": {
                  "type": "string"
                }
              }
            }
          }
        ],
        "description": "Train the Model named modelName and gives the name trainingName to the training run",
        "summary": "Train a Model",
        "operationId": "trainModel",
        "x-ISC_ServiceMethod": "trainModel",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/trainings/states": {
      "get": {
        "parameters": [
          {
            "in": "query",
            "name": "modelName",
            "type": "string",
            "description": "Name of the model"
          },
          {
            "in": "query",
            "name": "trainingName",
            "type": "string",
            "description": "Name of the training run"
          }
        ],
        "description": "Get the state of a speecific training run",
        "summary": "Get state of training run",
        "operationId": "getStateTrainingRun",
        "x-ISC_ServiceMethod": "getStateTrainingRun",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "state": {
                  "type": "string"
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/trainings/configurations": {
      "put": {
        "description": "Update ml configuration (H20 or AutoML, for now)",
        "summary": "Update configuration",
        "operationId": "changeConfiguration",
        "x-ISC_ServiceMethod": "changeConfiguration",
        "parameters": [
          {
            "name": "configName",
            "in": "body",
            "description": "Configuration name to use",
            "required": true,
            "schema": {
              "type": "object",
              "properties": {
                "configName": {
                  "type": "string"
                }
              }
            }
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/trainings/logs": {
      "get": {
        "parameters": [
          {
            "in": "query",
            "name": "trainingName",
            "type": "string",
            "description": "Name of the training run"
          }
        ],
        "description": "Get the log of a speecific training run",
        "summary": "Get log of training run",
        "operationId": "getLogTrainingRun",
        "x-ISC_ServiceMethod": "getLogTrainingRun",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "log": {
                  "type": "string"
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/validations": {
      "get": {
        "description": "Get all validation runs",
        "summary": "Get all validation runs",
        "operationId": "getValidationRuns",
        "x-ISC_ServiceMethod": "getValidationRuns",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "trainingRuns": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/mlValidationRun"
                  }
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      },
      "post": {
        "parameters": [
          {
            "in": "body",
            "name": "validationInfo",
            "required": true,
            "description": "Validation informations",
            "schema": {
              "type": "object",
              "properties": {
                "modelName": {
                  "type": "string"
                },
                "validationName": {
                  "type": "string"
                },
                "trainedModelName": {
                  "type": "string"
                },
                "fromTable": {
                  "type": "string"
                }
              }
            }
          }
        ],
        "description": "Validate the Model named modelName using trainedModelName trained model on the fromTable table and gives the name validationName to the validation run",
        "summary": "Validate a Model",
        "operationId": "validateModel",
        "x-ISC_ServiceMethod": "validateModel",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/validations/metrics": {
      "get": {
        "parameters": [
          {
            "in": "query",
            "name": "modelName",
            "type": "string",
            "description": "The model from which we want to select a validation run"
          },
          {
            "in": "query",
            "name": "validationName",
            "type": "string",
            "description": "The validation run we want to retreive the metrics from"
          }
        ],
        "description": "Get all metrics for given validation run",
        "summary": "Get metrics from validation run",
        "operationId": "getMetrics",
        "x-ISC_ServiceMethod": "getMetrics",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "metrics": {
                  "$ref": "#/definitions/mlValidationMetrics"
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "204": {
            "description": "(Not Found)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/predictions/models": {
      "get": {
        "description": "Get all trained models",
        "summary": "Get all trained models",
        "operationId": "getTrainedModels",
        "x-ISC_ServiceMethod": "getTrainedModels",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "models": {
                  "type": "array",
                  "items": {
                    "$ref": "#/definitions/mlTrainedModel"
                  }
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/predictions": {
      "get": {
        "parameters": [
          {
            "name": "model",
            "in": "query",
            "description": "Model to predict with",
            "required": true,
            "type": "string"
          },
          {
            "name": "trainedModel",
            "in": "query",
            "description": "Trained Model to predict with",
            "required": true,
            "type": "string"
          },
          {
            "name": "id",
            "in": "query",
            "description": "ID to predict with",
            "required": true,
            "type": "string"
          },
          {
            "name": "fromTable",
            "in": "query",
            "required": true,
            "type": "string",
            "description": "Table to predict from"
          }
        ],
        "description": "Predict with a certain model, a certain trained model and a certain id from a certain table",
        "summary": "Predict with a model and an id",
        "operationId": "predict",
        "x-ISC_ServiceMethod": "predict",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "predictedValue": {
                  "type": "string"
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    },
    "/ml/predictions/probabilities": {
      "get": {
        "parameters": [
          {
            "name": "model",
            "in": "query",
            "description": "Model to predict with",
            "required": true,
            "type": "string"
          },
          {
            "name": "trainedModel",
            "in": "query",
            "description": "Trained Model to predict with",
            "required": true,
            "type": "string"
          },
          {
            "name": "labelValue",
            "in": "query",
            "description": "Label of the value for probability",
            "required": true,
            "type": "string"
          },
          {
            "name": "id",
            "in": "query",
            "description": "ID to predict with",
            "required": true,
            "type": "string"
          },
          {
            "name": "fromTable",
            "in": "query",
            "description": "Table to predict from",
            "required": true,
            "type": "string"
          }
        ],
        "description": "Gives the probability of being predicted the labelValue with a certain model, a certain trained model and a certain id from a certain table",
        "summary": "Probabilities of having labelValue value predicted",
        "operationId": "probability",
        "x-ISC_ServiceMethod": "probability",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "probability": {
                  "type": "string"
                },
                "query": {
                  "type": "string"
                }
              }
            }
          },
          "400": {
            "description": "(Bad Request)"
          },
          "default": {
            "description": "(Unexpected Error)"
          }
        }
      }
    }
  },
  "definitions": {
    "passenger": {
      "type": "object",
      "properties": {
        "passengerId": {
          "type": "integer"
        },
        "survived": {
          "type": "boolean"
        },
        "class": {
          "type": "integer"
        },
        "name": {
          "type": "string"
        },
        "sex": {
          "type": "string"
        },
        "age": {
          "type": "number"
        },
        "sibSp": {
          "type": "integer"
        },
        "parCh": {
          "type": "integer"
        },
        "ticket": {
          "type": "string"
        },
        "fare": {
          "type": "number"
        },
        "cabin": {
          "type": "string"
        },
        "embarked": {
          "type": "string"
        }
      }
    },
    "patient": {
      "type": "object",
      "properties": {
        "patientId": {
          "type": "number"
        },
        "gender": {
          "type": "string"
        },
        "scheduledDay": {
          "type": "string"
        },
        "scheduledHour": {
          "type": "string"
        },
        "appointmentDay": {
          "type": "string"
        },
        "age": {
          "type": "number"
        },
        "neighborhood": {
          "type": "string"
        },
        "scholarship": {
          "type": "number"
        },
        "hypertension": {
          "type": "number"
        },
        "diabetes": {
          "type": "number"
        },
        "alcoholism": {
          "type": "number"
        },
        "handicap": {
          "type": "number"
        },
        "smsReceived": {
          "type": "number"
        },
        "noShow": {
          "type": "string"
        }
      }
    },
    "mlModel": {
      "type": "object",
      "properties": {
        "modelName": {
          "type": "string"
        },
        "description": {
          "type": "string"
        },
        "predictingColumnName": {
          "type": "string"
        },
        "predictingColumntype": {
          "type": "string"
        },
        "withColumns": {
          "type": "string"
        },
        "createTimestamp": {
          "type": "string"
        },
        "defaultTrainedModelName": {
          "type": "string"
        },
        "defaultSettings": {
          "type": "string"
        },
        "defaultTrainingQuery": {
          "type": "string"
        }
      }
    },
    "mlTrainingRun": {
      "type": "object",
      "properties": {
        "modelName": {
          "type": "string"
        },
        "trainingRunName": {
          "type": "string"
        },
        "provider": {
          "type": "string"
        },
        "startTimestamp": {
          "type": "string"
        },
        "completedTimestamp": {
          "type": "string"
        },
        "trainingDuration": {
          "type": "string"
        },
        "runStatus": {
          "type": "string"
        },
        "statusCode": {
          "type": "string"
        },
        "log": {
          "type": "string"
        },
        "settings": {
          "type": "string"
        },
        "mlConfigurationName": {
          "type": "string"
        },
        "trainingRunQuery": {
          "type": "string"
        }
      }
    },
    "mlTrainedModel": {
      "type": "object",
      "properties": {
        "modelName": {
          "type": "string"
        },
        "trainedModelName": {
          "type": "string"
        },
        "provider": {
          "type": "string"
        },
        "trainedTimestamp": {
          "type": "string"
        },
        "modelType": {
          "type": "string"
        },
        "modelInfo": {
          "type": "string"
        }
      }
    },
    "mlValidationRun": {
      "type": "object",
      "properties": {
        "modelName": {
          "type": "string"
        },
        "trainedModelName": {
          "type": "string"
        },
        "validationRunName": {
          "type": "string"
        },
        "startTimestamp": {
          "type": "string"
        },
        "completedTimestamp": {
          "type": "string"
        },
        "validationDuration": {
          "type": "string"
        },
        "runStatus": {
          "type": "string"
        },
        "statusCode": {
          "type": "string"
        },
        "log": {
          "type": "string"
        },
        "settings": {
          "type": "string"
        },
        "validationRunQuery": {
          "type": "string"
        }
      }
    },
    "mlValidationMetrics": {
      "type": "array",
      "items": {
        "type": "string"
      }
    }
  }
}
}

}

Class Titanic.REST.spec Extends %REST.Spec [ ProcedureBlock ]
{

XData OpenAPI [ MimeType = application/json ]
{
{
  "swagger": "2.0",
  "info": {
    "title": "InterSystems IRIS REST CRUD for Integrated ML Demo",
    "description": "Rest API for the Integrated ML Demo on the Titanic database",
    "version": "0.1",
    "contact": {
      "email": "theophile.thierry@intersystems.com"
    },
    "license": {
      "name": " 2.0",
      "url": "http://www.apache.org/licenses/LICENSE-2.0.html"
    }
  },
  "host": "localhost:52775",
  "basePath": "/api",
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
    "/": {
      "get": {
        "description": " IntegratedMLDemo general information ",
        "summary": " Server Info ",
        "operationId": "GetInfo",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "version": {
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
    "/passengers": {
      "get": {
        "description": " Retreive all the records of Titanic.Table.Passenger ",
        "summary": " Get all records of Passenger class ",
        "operationId": "GetAllPassengers",
        "x-ISC_ServiceMethod": "GetAllPassengers",
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "Id": {
                  "type": "integer"
                },
                "Passenger": {
                  "$ref": "#/definitions/Passenger"
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
        "description": " Create a new Titanic.Table.Passenger record ",
        "summary": " Create a Passenger ",
        "operationId": "CreatePassenger",
        "x-ISC_ServiceMethod": "CreatePassenger",
        "parameters": [
          {
            "name": "payloadBody",
            "in": "body",
            "description": "Request body contents",
            "required": false,
            "schema": {
              "$ref": "#/definitions/Passenger"
            }
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "type": "object",
              "properties": {
                "Id": {
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
        "description": " Return one record of Titanic.Table.Passenger ",
        "summary": " GET method to return JSON for a given passenger id",
        "operationId": "GetPassenger",
        "x-ISC_ServiceMethod": "GetPassenger",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "string"
          }
        ],
        "responses": {
          "200": {
            "description": "(Expected Result)",
            "schema": {
              "$ref": "#/definitions/Passenger"
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
        "description": " Update a record of Titanic.Table.Passenger with id ",
        "summary": " Update a passenger with id",
        "operationId": "UpdatePassenger",
        "x-ISC_ServiceMethod": "UpdatePassenger",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "string"
          },
          {
            "name": "payloadBody",
            "in": "body",
            "description": "Request body contents",
            "required": false,
            "schema": {
              "$ref": "#/definitions/Passenger"
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
        "description": " Delete a record of Titanic.Table.Passenger with id ",
        "summary": " Delete a passenger with id",
        "operationId": "DeletePassenger",
        "x-ISC_ServiceMethod": "DeletePassenger",
        "parameters": [
          {
            "name": "id",
            "in": "path",
            "required": true,
            "type": "string"
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
    }
  },
  "definitions": {
    "Passenger": {
      "type": "object",
      "properties": {
        "Class": {
          "type": "integer"
        },
        "Survived": {
          "type": "boolean"
        },
        "Name": {
          "type": "string"
        },
        "Sex": {
          "type": "string"
        },
        "Age": {
          "type": "number"
        },
        "Sibsp": {
          "type": "integer"
        },
        "Parch": {
          "type": "integer"
        },
        "Ticket": {
          "type": "string"
        },
        "Fare": {
          "type": "number"
        },
        "Cabin": {
          "type": "string"
        },
        "Embarked": {
          "type": "string"
        },
        "Boat": {
          "type": "string"
        },
        "Body": {
          "type": "integer"
        },
        "Destination": {
          "type": "string"
        }
      }
    }
  }
}
}

}

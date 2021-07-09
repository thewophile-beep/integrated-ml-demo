# coding: utf-8

from __future__ import absolute_import

from flask import json
from six import BytesIO

from swagger_server.models.config_name import ConfigName  # noqa: E501
from swagger_server.models.create_info import CreateInfo  # noqa: E501
from swagger_server.models.passenger import Passenger  # noqa: E501
from swagger_server.models.patient import Patient  # noqa: E501
from swagger_server.models.payload import Payload  # noqa: E501
from swagger_server.models.training_info import TrainingInfo  # noqa: E501
from swagger_server.models.validation_info import ValidationInfo  # noqa: E501
from swagger_server.test import BaseTestCase


class TestDefaultController(BaseTestCase):
    """DefaultController integration test stubs"""

    def test_alter_dr_configuration(self):
        """Test case for alter_dr_configuration

        Alter DataRobot configuration
        """
        payload = Payload()
        response = self.client.open(
            '/api/integratedML/ml/trainings/configurations/datarobot',
            method='PUT',
            data=json.dumps(payload),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_change_configuration(self):
        """Test case for change_configuration

        Update configuration
        """
        configName = ConfigName()
        response = self.client.open(
            '/api/integratedML/ml/trainings/configurations',
            method='PUT',
            data=json.dumps(configName),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_create_dr_configuration(self):
        """Test case for create_dr_configuration

        Create DataRobot configuration
        """
        payload = Payload()
        response = self.client.open(
            '/api/integratedML/ml/trainings/configurations/datarobot',
            method='POST',
            data=json.dumps(payload),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_create_model(self):
        """Test case for create_model

        Create a Model
        """
        createInfo = CreateInfo()
        response = self.client.open(
            '/api/integratedML/ml/models',
            method='POST',
            data=json.dumps(createInfo),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_create_passenger(self):
        """Test case for create_passenger

        Create a passenger
        """
        payloadBody = Passenger()
        response = self.client.open(
            '/api/integratedML/passengers',
            method='POST',
            data=json.dumps(payloadBody),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_create_patient(self):
        """Test case for create_patient

        Create a patient
        """
        payloadBody = Patient()
        response = self.client.open(
            '/api/integratedML/patients',
            method='POST',
            data=json.dumps(payloadBody),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_delete_model(self):
        """Test case for delete_model

        Delete a model
        """
        query_string = [('modelName', 'modelName_example')]
        response = self.client.open(
            '/api/integratedML/ml/models',
            method='DELETE',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_delete_passenger(self):
        """Test case for delete_passenger

        Delete passenger {id}
        """
        response = self.client.open(
            '/api/integratedML/passengers/{id}'.format(id=56),
            method='DELETE',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_delete_patient(self):
        """Test case for delete_patient

        Delete patient {id}
        """
        response = self.client.open(
            '/api/integratedML/patients/{id}'.format(id=56),
            method='DELETE',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_all_configurations(self):
        """Test case for get_all_configurations

        Get configurations
        """
        response = self.client.open(
            '/api/integratedML/ml/trainings/configurations',
            method='GET',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_all_models(self):
        """Test case for get_all_models

        Get all models
        """
        response = self.client.open(
            '/api/integratedML/ml/models',
            method='GET',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_all_passengers(self):
        """Test case for get_all_passengers

        Get passengers with pagination and search by name possible
        """
        query_string = [('currPage', 8.14),
                        ('pageSize', 8.14),
                        ('name', 'name_example')]
        response = self.client.open(
            '/api/integratedML/passengers',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_all_patients(self):
        """Test case for get_all_patients

        Get patients with pagination and search by name possible
        """
        query_string = [('currPage', 8.14),
                        ('pageSize', 8.14),
                        ('id', 'id_example')]
        response = self.client.open(
            '/api/integratedML/patients',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_log_training_run(self):
        """Test case for get_log_training_run

        Get log of training run
        """
        query_string = [('trainingName', 'trainingName_example')]
        response = self.client.open(
            '/api/integratedML/ml/trainings/logs',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_metrics(self):
        """Test case for get_metrics

        Get metrics from validation run
        """
        query_string = [('modelName', 'modelName_example'),
                        ('validationName', 'validationName_example')]
        response = self.client.open(
            '/api/integratedML/ml/validations/metrics',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_passenger(self):
        """Test case for get_passenger

        Get passenger n°{id} info
        """
        response = self.client.open(
            '/api/integratedML/passengers/{id}'.format(id=56),
            method='GET',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_patient(self):
        """Test case for get_patient

        Get patient n°{id} info
        """
        response = self.client.open(
            '/api/integratedML/patients/{id}'.format(id=56),
            method='GET',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_state_training_run(self):
        """Test case for get_state_training_run

        Get state of training run
        """
        query_string = [('modelName', 'modelName_example'),
                        ('trainingName', 'trainingName_example')]
        response = self.client.open(
            '/api/integratedML/ml/trainings/states',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_table_size(self):
        """Test case for get_table_size

        Get nb of objects in table
        """
        query_string = [('table', 'table_example')]
        response = self.client.open(
            '/api/integratedML/ml/tablesize',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_trained_models(self):
        """Test case for get_trained_models

        Get all trained models
        """
        response = self.client.open(
            '/api/integratedML/ml/predictions/models',
            method='GET',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_training_runs(self):
        """Test case for get_training_runs

        Get all training runs
        """
        response = self.client.open(
            '/api/integratedML/ml/trainings',
            method='GET',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_get_validation_runs(self):
        """Test case for get_validation_runs

        Get all validation runs
        """
        response = self.client.open(
            '/api/integratedML/ml/validations',
            method='GET',
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_predict(self):
        """Test case for predict

        Predict with a model and an id
        """
        query_string = [('model', 'model_example'),
                        ('trainedModel', 'trainedModel_example'),
                        ('id', 'id_example'),
                        ('fromTable', 'fromTable_example')]
        response = self.client.open(
            '/api/integratedML/ml/predictions',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_probability(self):
        """Test case for probability

        Probabilities of having labelValue value predicted
        """
        query_string = [('model', 'model_example'),
                        ('trainedModel', 'trainedModel_example'),
                        ('labelValue', 'labelValue_example'),
                        ('id', 'id_example'),
                        ('fromTable', 'fromTable_example')]
        response = self.client.open(
            '/api/integratedML/ml/predictions/probabilities',
            method='GET',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_purge_model(self):
        """Test case for purge_model

        Purge runs from model
        """
        query_string = [('modelName', 'modelName_example')]
        response = self.client.open(
            '/api/integratedML/ml/models/purge',
            method='DELETE',
            content_type='application/json',
            query_string=query_string)
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_train_model(self):
        """Test case for train_model

        Train a Model
        """
        trainingInfo = TrainingInfo()
        response = self.client.open(
            '/api/integratedML/ml/trainings',
            method='POST',
            data=json.dumps(trainingInfo),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_update_passenger(self):
        """Test case for update_passenger

        Update passenger {id} info
        """
        payloadBody = Passenger()
        response = self.client.open(
            '/api/integratedML/passengers/{id}'.format(id=56),
            method='PUT',
            data=json.dumps(payloadBody),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_update_patient(self):
        """Test case for update_patient

        Update patient {id} info
        """
        payloadBody = Patient()
        response = self.client.open(
            '/api/integratedML/patients/{id}'.format(id=56),
            method='PUT',
            data=json.dumps(payloadBody),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))

    def test_validate_model(self):
        """Test case for validate_model

        Validate a Model
        """
        validationInfo = ValidationInfo()
        response = self.client.open(
            '/api/integratedML/ml/validations',
            method='POST',
            data=json.dumps(validationInfo),
            content_type='application/json')
        self.assert200(response,
                       'Response body is : ' + response.data.decode('utf-8'))


if __name__ == '__main__':
    import unittest
    unittest.main()

# coding: utf-8

from __future__ import absolute_import
from datetime import date, datetime  # noqa: F401

from typing import List, Dict  # noqa: F401

from swagger_server.models.base_model_ import Model
from swagger_server import util


class MlModel(Model):
    """NOTE: This class is auto generated by the swagger code generator program.

    Do not edit the class manually.
    """

    def __init__(self, model_name: str=None, description: str=None, predicting_column_name: str=None, predicting_columntype: str=None, with_columns: str=None, create_timestamp: str=None, default_trained_model_name: str=None, default_settings: str=None, default_training_query: str=None):  # noqa: E501
        """MlModel - a model defined in Swagger

        :param model_name: The model_name of this MlModel.  # noqa: E501
        :type model_name: str
        :param description: The description of this MlModel.  # noqa: E501
        :type description: str
        :param predicting_column_name: The predicting_column_name of this MlModel.  # noqa: E501
        :type predicting_column_name: str
        :param predicting_columntype: The predicting_columntype of this MlModel.  # noqa: E501
        :type predicting_columntype: str
        :param with_columns: The with_columns of this MlModel.  # noqa: E501
        :type with_columns: str
        :param create_timestamp: The create_timestamp of this MlModel.  # noqa: E501
        :type create_timestamp: str
        :param default_trained_model_name: The default_trained_model_name of this MlModel.  # noqa: E501
        :type default_trained_model_name: str
        :param default_settings: The default_settings of this MlModel.  # noqa: E501
        :type default_settings: str
        :param default_training_query: The default_training_query of this MlModel.  # noqa: E501
        :type default_training_query: str
        """
        self.swagger_types = {
            'model_name': str,
            'description': str,
            'predicting_column_name': str,
            'predicting_columntype': str,
            'with_columns': str,
            'create_timestamp': str,
            'default_trained_model_name': str,
            'default_settings': str,
            'default_training_query': str
        }

        self.attribute_map = {
            'model_name': 'modelName',
            'description': 'description',
            'predicting_column_name': 'predictingColumnName',
            'predicting_columntype': 'predictingColumntype',
            'with_columns': 'withColumns',
            'create_timestamp': 'createTimestamp',
            'default_trained_model_name': 'defaultTrainedModelName',
            'default_settings': 'defaultSettings',
            'default_training_query': 'defaultTrainingQuery'
        }

        self._model_name = model_name
        self._description = description
        self._predicting_column_name = predicting_column_name
        self._predicting_columntype = predicting_columntype
        self._with_columns = with_columns
        self._create_timestamp = create_timestamp
        self._default_trained_model_name = default_trained_model_name
        self._default_settings = default_settings
        self._default_training_query = default_training_query

    @classmethod
    def from_dict(cls, dikt) -> 'MlModel':
        """Returns the dict as a model

        :param dikt: A dict.
        :type: dict
        :return: The mlModel of this MlModel.  # noqa: E501
        :rtype: MlModel
        """
        return util.deserialize_model(dikt, cls)

    @property
    def model_name(self) -> str:
        """Gets the model_name of this MlModel.


        :return: The model_name of this MlModel.
        :rtype: str
        """
        return self._model_name

    @model_name.setter
    def model_name(self, model_name: str):
        """Sets the model_name of this MlModel.


        :param model_name: The model_name of this MlModel.
        :type model_name: str
        """

        self._model_name = model_name

    @property
    def description(self) -> str:
        """Gets the description of this MlModel.


        :return: The description of this MlModel.
        :rtype: str
        """
        return self._description

    @description.setter
    def description(self, description: str):
        """Sets the description of this MlModel.


        :param description: The description of this MlModel.
        :type description: str
        """

        self._description = description

    @property
    def predicting_column_name(self) -> str:
        """Gets the predicting_column_name of this MlModel.


        :return: The predicting_column_name of this MlModel.
        :rtype: str
        """
        return self._predicting_column_name

    @predicting_column_name.setter
    def predicting_column_name(self, predicting_column_name: str):
        """Sets the predicting_column_name of this MlModel.


        :param predicting_column_name: The predicting_column_name of this MlModel.
        :type predicting_column_name: str
        """

        self._predicting_column_name = predicting_column_name

    @property
    def predicting_columntype(self) -> str:
        """Gets the predicting_columntype of this MlModel.


        :return: The predicting_columntype of this MlModel.
        :rtype: str
        """
        return self._predicting_columntype

    @predicting_columntype.setter
    def predicting_columntype(self, predicting_columntype: str):
        """Sets the predicting_columntype of this MlModel.


        :param predicting_columntype: The predicting_columntype of this MlModel.
        :type predicting_columntype: str
        """

        self._predicting_columntype = predicting_columntype

    @property
    def with_columns(self) -> str:
        """Gets the with_columns of this MlModel.


        :return: The with_columns of this MlModel.
        :rtype: str
        """
        return self._with_columns

    @with_columns.setter
    def with_columns(self, with_columns: str):
        """Sets the with_columns of this MlModel.


        :param with_columns: The with_columns of this MlModel.
        :type with_columns: str
        """

        self._with_columns = with_columns

    @property
    def create_timestamp(self) -> str:
        """Gets the create_timestamp of this MlModel.


        :return: The create_timestamp of this MlModel.
        :rtype: str
        """
        return self._create_timestamp

    @create_timestamp.setter
    def create_timestamp(self, create_timestamp: str):
        """Sets the create_timestamp of this MlModel.


        :param create_timestamp: The create_timestamp of this MlModel.
        :type create_timestamp: str
        """

        self._create_timestamp = create_timestamp

    @property
    def default_trained_model_name(self) -> str:
        """Gets the default_trained_model_name of this MlModel.


        :return: The default_trained_model_name of this MlModel.
        :rtype: str
        """
        return self._default_trained_model_name

    @default_trained_model_name.setter
    def default_trained_model_name(self, default_trained_model_name: str):
        """Sets the default_trained_model_name of this MlModel.


        :param default_trained_model_name: The default_trained_model_name of this MlModel.
        :type default_trained_model_name: str
        """

        self._default_trained_model_name = default_trained_model_name

    @property
    def default_settings(self) -> str:
        """Gets the default_settings of this MlModel.


        :return: The default_settings of this MlModel.
        :rtype: str
        """
        return self._default_settings

    @default_settings.setter
    def default_settings(self, default_settings: str):
        """Sets the default_settings of this MlModel.


        :param default_settings: The default_settings of this MlModel.
        :type default_settings: str
        """

        self._default_settings = default_settings

    @property
    def default_training_query(self) -> str:
        """Gets the default_training_query of this MlModel.


        :return: The default_training_query of this MlModel.
        :rtype: str
        """
        return self._default_training_query

    @default_training_query.setter
    def default_training_query(self, default_training_query: str):
        """Sets the default_training_query of this MlModel.


        :param default_training_query: The default_training_query of this MlModel.
        :type default_training_query: str
        """

        self._default_training_query = default_training_query

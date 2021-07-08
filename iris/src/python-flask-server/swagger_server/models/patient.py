# coding: utf-8

from __future__ import absolute_import
from datetime import date, datetime  # noqa: F401

from typing import List, Dict  # noqa: F401

from swagger_server.models.base_model_ import Model
from swagger_server import util


class Patient(Model):
    """NOTE: This class is auto generated by the swagger code generator program.

    Do not edit the class manually.
    """

    def __init__(self, patient_id: float=None, gender: str=None, scheduled_day: str=None, scheduled_hour: str=None, appointment_day: str=None, age: float=None, neighborhood: str=None, scholarship: float=None, hypertension: float=None, diabetes: float=None, alcoholism: float=None, handicap: float=None, sms_received: float=None, no_show: str=None):  # noqa: E501
        """Patient - a model defined in Swagger

        :param patient_id: The patient_id of this Patient.  # noqa: E501
        :type patient_id: float
        :param gender: The gender of this Patient.  # noqa: E501
        :type gender: str
        :param scheduled_day: The scheduled_day of this Patient.  # noqa: E501
        :type scheduled_day: str
        :param scheduled_hour: The scheduled_hour of this Patient.  # noqa: E501
        :type scheduled_hour: str
        :param appointment_day: The appointment_day of this Patient.  # noqa: E501
        :type appointment_day: str
        :param age: The age of this Patient.  # noqa: E501
        :type age: float
        :param neighborhood: The neighborhood of this Patient.  # noqa: E501
        :type neighborhood: str
        :param scholarship: The scholarship of this Patient.  # noqa: E501
        :type scholarship: float
        :param hypertension: The hypertension of this Patient.  # noqa: E501
        :type hypertension: float
        :param diabetes: The diabetes of this Patient.  # noqa: E501
        :type diabetes: float
        :param alcoholism: The alcoholism of this Patient.  # noqa: E501
        :type alcoholism: float
        :param handicap: The handicap of this Patient.  # noqa: E501
        :type handicap: float
        :param sms_received: The sms_received of this Patient.  # noqa: E501
        :type sms_received: float
        :param no_show: The no_show of this Patient.  # noqa: E501
        :type no_show: str
        """
        self.swagger_types = {
            'patient_id': float,
            'gender': str,
            'scheduled_day': str,
            'scheduled_hour': str,
            'appointment_day': str,
            'age': float,
            'neighborhood': str,
            'scholarship': float,
            'hypertension': float,
            'diabetes': float,
            'alcoholism': float,
            'handicap': float,
            'sms_received': float,
            'no_show': str
        }

        self.attribute_map = {
            'patient_id': 'patientId',
            'gender': 'gender',
            'scheduled_day': 'scheduledDay',
            'scheduled_hour': 'scheduledHour',
            'appointment_day': 'appointmentDay',
            'age': 'age',
            'neighborhood': 'neighborhood',
            'scholarship': 'scholarship',
            'hypertension': 'hypertension',
            'diabetes': 'diabetes',
            'alcoholism': 'alcoholism',
            'handicap': 'handicap',
            'sms_received': 'smsReceived',
            'no_show': 'noShow'
        }

        self._patient_id = patient_id
        self._gender = gender
        self._scheduled_day = scheduled_day
        self._scheduled_hour = scheduled_hour
        self._appointment_day = appointment_day
        self._age = age
        self._neighborhood = neighborhood
        self._scholarship = scholarship
        self._hypertension = hypertension
        self._diabetes = diabetes
        self._alcoholism = alcoholism
        self._handicap = handicap
        self._sms_received = sms_received
        self._no_show = no_show

    @classmethod
    def from_dict(cls, dikt) -> 'Patient':
        """Returns the dict as a model

        :param dikt: A dict.
        :type: dict
        :return: The patient of this Patient.  # noqa: E501
        :rtype: Patient
        """
        return util.deserialize_model(dikt, cls)

    @property
    def patient_id(self) -> float:
        """Gets the patient_id of this Patient.


        :return: The patient_id of this Patient.
        :rtype: float
        """
        return self._patient_id

    @patient_id.setter
    def patient_id(self, patient_id: float):
        """Sets the patient_id of this Patient.


        :param patient_id: The patient_id of this Patient.
        :type patient_id: float
        """

        self._patient_id = patient_id

    @property
    def gender(self) -> str:
        """Gets the gender of this Patient.


        :return: The gender of this Patient.
        :rtype: str
        """
        return self._gender

    @gender.setter
    def gender(self, gender: str):
        """Sets the gender of this Patient.


        :param gender: The gender of this Patient.
        :type gender: str
        """

        self._gender = gender

    @property
    def scheduled_day(self) -> str:
        """Gets the scheduled_day of this Patient.


        :return: The scheduled_day of this Patient.
        :rtype: str
        """
        return self._scheduled_day

    @scheduled_day.setter
    def scheduled_day(self, scheduled_day: str):
        """Sets the scheduled_day of this Patient.


        :param scheduled_day: The scheduled_day of this Patient.
        :type scheduled_day: str
        """

        self._scheduled_day = scheduled_day

    @property
    def scheduled_hour(self) -> str:
        """Gets the scheduled_hour of this Patient.


        :return: The scheduled_hour of this Patient.
        :rtype: str
        """
        return self._scheduled_hour

    @scheduled_hour.setter
    def scheduled_hour(self, scheduled_hour: str):
        """Sets the scheduled_hour of this Patient.


        :param scheduled_hour: The scheduled_hour of this Patient.
        :type scheduled_hour: str
        """

        self._scheduled_hour = scheduled_hour

    @property
    def appointment_day(self) -> str:
        """Gets the appointment_day of this Patient.


        :return: The appointment_day of this Patient.
        :rtype: str
        """
        return self._appointment_day

    @appointment_day.setter
    def appointment_day(self, appointment_day: str):
        """Sets the appointment_day of this Patient.


        :param appointment_day: The appointment_day of this Patient.
        :type appointment_day: str
        """

        self._appointment_day = appointment_day

    @property
    def age(self) -> float:
        """Gets the age of this Patient.


        :return: The age of this Patient.
        :rtype: float
        """
        return self._age

    @age.setter
    def age(self, age: float):
        """Sets the age of this Patient.


        :param age: The age of this Patient.
        :type age: float
        """

        self._age = age

    @property
    def neighborhood(self) -> str:
        """Gets the neighborhood of this Patient.


        :return: The neighborhood of this Patient.
        :rtype: str
        """
        return self._neighborhood

    @neighborhood.setter
    def neighborhood(self, neighborhood: str):
        """Sets the neighborhood of this Patient.


        :param neighborhood: The neighborhood of this Patient.
        :type neighborhood: str
        """

        self._neighborhood = neighborhood

    @property
    def scholarship(self) -> float:
        """Gets the scholarship of this Patient.


        :return: The scholarship of this Patient.
        :rtype: float
        """
        return self._scholarship

    @scholarship.setter
    def scholarship(self, scholarship: float):
        """Sets the scholarship of this Patient.


        :param scholarship: The scholarship of this Patient.
        :type scholarship: float
        """

        self._scholarship = scholarship

    @property
    def hypertension(self) -> float:
        """Gets the hypertension of this Patient.


        :return: The hypertension of this Patient.
        :rtype: float
        """
        return self._hypertension

    @hypertension.setter
    def hypertension(self, hypertension: float):
        """Sets the hypertension of this Patient.


        :param hypertension: The hypertension of this Patient.
        :type hypertension: float
        """

        self._hypertension = hypertension

    @property
    def diabetes(self) -> float:
        """Gets the diabetes of this Patient.


        :return: The diabetes of this Patient.
        :rtype: float
        """
        return self._diabetes

    @diabetes.setter
    def diabetes(self, diabetes: float):
        """Sets the diabetes of this Patient.


        :param diabetes: The diabetes of this Patient.
        :type diabetes: float
        """

        self._diabetes = diabetes

    @property
    def alcoholism(self) -> float:
        """Gets the alcoholism of this Patient.


        :return: The alcoholism of this Patient.
        :rtype: float
        """
        return self._alcoholism

    @alcoholism.setter
    def alcoholism(self, alcoholism: float):
        """Sets the alcoholism of this Patient.


        :param alcoholism: The alcoholism of this Patient.
        :type alcoholism: float
        """

        self._alcoholism = alcoholism

    @property
    def handicap(self) -> float:
        """Gets the handicap of this Patient.


        :return: The handicap of this Patient.
        :rtype: float
        """
        return self._handicap

    @handicap.setter
    def handicap(self, handicap: float):
        """Sets the handicap of this Patient.


        :param handicap: The handicap of this Patient.
        :type handicap: float
        """

        self._handicap = handicap

    @property
    def sms_received(self) -> float:
        """Gets the sms_received of this Patient.


        :return: The sms_received of this Patient.
        :rtype: float
        """
        return self._sms_received

    @sms_received.setter
    def sms_received(self, sms_received: float):
        """Sets the sms_received of this Patient.


        :param sms_received: The sms_received of this Patient.
        :type sms_received: float
        """

        self._sms_received = sms_received

    @property
    def no_show(self) -> str:
        """Gets the no_show of this Patient.


        :return: The no_show of this Patient.
        :rtype: str
        """
        return self._no_show

    @no_show.setter
    def no_show(self, no_show: str):
        """Sets the no_show of this Patient.


        :param no_show: The no_show of this Patient.
        :type no_show: str
        """

        self._no_show = no_show

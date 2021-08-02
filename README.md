# 1. Integrated ML Demonstration

This repository is a demonstration of IntegratedML and Embedded Python. 

- [1. Integrated ML Demonstration](#1-integrated-ml-demonstration)
- [2. Building the demo](#2-building-the-demo)
  - [2.1. Architecture](#21-architecture)
  - [2.2. Building the nginx container](#22-building-the-nginx-container)
- [3. Running the demo](#3-running-the-demo)
- [4. Embedded Python and Flask](#4-embedded-python-and-flask)
- [5. IntegratedML](#5-integratedml)
  - [5.1. Exploring both datasets](#51-exploring-both-datasets)
  - [5.2. Managing models](#52-managing-models)
    - [5.2.1. Creating a model](#521-creating-a-model)
    - [5.2.2. Training a model](#522-training-a-model)
    - [5.2.3. Validating a model](#523-validating-a-model)
    - [5.2.4. Making predictions](#524-making-predictions)
- [6. Using COS](#6-using-cos)
- [7. Going further](#7-going-further)
- [8. Conclusion](#8-conclusion)
- [9. TODO](#9-todo)

# 2. Building the demo

To build the demo, you just have to run the command:
````
docker compose up
````

## 2.1. Architecture

Two containers will be built: one with IRIS and one with an nginx server. 

![containers](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/flask/misc/img/containers.png)

The IRIS image used contains Embedded Python. After building, the container will run a wsgi server with the Flask API.

We are using the community package csvgen to import the titanic dataset into iris. For the noshow dataset, we use another custom method (the `Load()` classmethod of the `Util.Loader` class). In order for the container to have access to the csv files, we bind the `iris/` local directory to the `/opt/irisapp/` directory in the container.

## 2.2. Building the nginx container

In order to build our nginx container, docker uses multi-stage building. First, it creates a container with node. It then installs npm and copy all of our files in that container. It builds the project with the command `ng build`, and the output file is copied in a new container that only contains nginx. 

Thanks to that manoeuvre, we obtain a very light container that does not contain all of the librairies and tools needed to build the webpage. 

You can check the details of that multi-build in the `angular/Dockerfile` file. We also set up our nginx server parameters thanks to the `angular/nginx.default.conf` file.

# 3. Running the demo

Just go to the address: http://localhost:8080/ and That's it! Enjoy!

# 4. Embedded Python and Flask

The back-end is made with Python Flask. We use Embedded Python in order to call iris classes and execute queries from python. 

For that, we use `irispython` as a python interepreter, and do:
```python
import iris
```
Right at the beginning of the file

We will then be able to run methods such as:

![flaskExample](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/flask/misc/img/flaskExample.png)

As you can see, in order to GET a passenger with an ID, we just execute a query and use its result set. 

We can also directly use the IRIS objects:

![flaskObjectExample](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/flask/misc/img/flaskObjectExample.png)

Here, we use an SQL query to get all the IDs in the table, and we then retreive each passenger from the table with the `%OpenId()` method from the `Titanic.Table.Passenger` class (note that since `%` is an illegal character in Python, we use `_` instead).

# 5. IntegratedML

## 5.1. Exploring both datasets

For both datasets, you'll have access to a complete CRUD, enabling you to modify at will the saved tables. 

In order to switch from one dataset to the other, you can press the button in the top right-hand corner. 

## 5.2. Managing models

### 5.2.1. Creating a model

Once you have discovered the data, you can create model predicting the value you want. 

By pressing in the side navigation menu `Model Manager`, in the `Model List` you'll have access to the following page (here in the case of the NoShow dataset):

![modelList](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelList.png)

You can choose what value you want to predict, the name of your model, and with what variables you want to predict. 

In the side menu, you can toggle `See SQL queries?` to see how the models are managed in IRIS. 

After creating a model you should see this: 

![modelCreated](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelCreated.png)

As you can see, creating a model only takes one SQL query. The informations you have are all the information you can retreive from IRIS. 

In the `actions` column, you can delete a model or purge it. Purging a model will remove all of its training runs (and their validation runs) except for the last one. 

### 5.2.2. Training a model

In the next tab, you will be able to train your models. 

You have the choice between 3 providers. InterSystems' `AutoML`, `H2O`, an open-source solution, and `DataRobot`, of which you can have a  free 14-day trial if you register on their site.

You can select the percentage of the dataset you want to use to train your model. Since it can take a long time to train for large datasets, for the purpose of demonstrations, it is possible to take a smaller dataset.

Here we have trained a model using all of the Titanic Dataset:


![modelTrained](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelTrained.png)

The button in the `actions` column will enable you to see the log. For the AutoML, you will see what the algorithm actually did: how it has prepared the data and how it has chosen the model to use. 

Training a model only takes a single SQL query, as you can see in the messages section of the sidenav menu.

Keep in mind that in these two tabs, you will only see the models that concern the dataset you are actually using.


### 5.2.3. Validating a model

Finally, you can validate a model in the final tab. Clicking on a validation run will pop up a dialog with the metrics associated with the validation. There again, you can choose a percentage of the dataset to use for the validation. 

![modelValidated](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelValidated.png)

Once again, it only takes a single SQL query.


### 5.2.4. Making predictions

In the `Make Predictions` menu, last tab, you can make predictions using your newly trained models.

You just have to search for a passenger / patient and select it, select one of the trained model and press predict. 

In the case of a classification model (like in this example, for predicting the survival), the prediction will be associated with the probability of being in the predicted class. 

In the case of Mrs. Fatima Masselmani, the model correctly predicted that she survived, with a probability of 73%. Just below this prediction, you can see the data used by the model:

![prediction](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/prediction.png)

Once again, it takes on query to retreive the prediction and one for the probability.

# 6. Using COS

The demonstration actually provides two APIs. We use the Flask API with Embedded Python, but a REST service in COS has also been setup at the building of the container.

By pressing the button in the top right-hand side **"Switch to COS API"**, you will be able to use this service.

Notice how nothing changes. Both APIs are equivalent and work in the same way. 

# 7. Going further

If you want more explainability (more than what the log can offer you), we suggest you using the DataRobot provider. 

For that, you need to go at the address of your DataRobot instance, and look for the `Developer Tools` to get your token. Upon trainnig your model, the webpage will ask you your token. 

Once the training started, you can access your DataRobot instance to know a lot more about your dataset and your models:

![DRdata](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/DRdata.png)

Here, we can see that the `sex` and the `name` fields of every Passenger are the most important values to predict the survival. We can also see that the `fare` field contains outliers.

Once the models trained, you can have access to **a lot** of details, here's a peek: 

![DRmodelDetails](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/DRmodelDetails.png)

# 8. Conclusion

Through this demonstration, we have been able to see how easy it was to create, train and validate a model as well as to predict values through very few SQL queries. 

We did this using a RESTful API with Python Flask, using Embedded Python, and we have done a comparison with a COS API.

The front-end has been made with Angular.

# 9. TODO
with future embedded Python releases: 
- [ ] Find a way to catch the irisbuiltins.SQLError to return 400 messages instead of the default 500 (Cast)

- [ ] Un-comment the changeConfiguration method. For some reason, changing the ML Configuration with `iris.cls("%SYS.ML.Configuration")._SetSystemDefault()` makes IRIS go boom. And changing it with an SQL query doesn't work in all namespaces / users

- [x] Find a way to make training work. When training a model, in %ML.Utils.RunMethodWithCapture(), $ZU(82, 12) makes IRIS crash. Already in Jira.
Bypass: commenting all lines with ZU, and setting capture to 1 in said method
(but to do that we need to go to System Admin > Configuration > System Configuration > Local Databases and uncheck Mount Read-Only for the IRISLIB db)
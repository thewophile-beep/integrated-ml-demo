# 1. Integrated ML Demonstration

This repository is a demonstration of integratedML. 

Using a web application, you will be able to create, train and validate the models you want on two datasets, the **Titanic** and the **NoShow** datasets. 

The front-end has been done with angular and the back-end with IRIS. 

- [1. Integrated ML Demonstration](#1-integrated-ml-demonstration)
- [2. Building the demo](#2-building-the-demo)
  - [2.1. Architecture](#21-architecture)
  - [2.2. Building the nginx container](#22-building-the-nginx-container)
- [3. Running the demo](#3-running-the-demo)
  - [3.1. Exploring both datasets](#31-exploring-both-datasets)
  - [3.2. Managing models](#32-managing-models)
    - [3.2.1. Creating a model](#321-creating-a-model)
    - [3.2.2. Training a model](#322-training-a-model)
    - [3.2.3. Validating a model](#323-validating-a-model)
    - [3.2.4. Making predictions](#324-making-predictions)
- [4. Going further](#4-going-further)
- [5. Conclusion](#5-conclusion)

# 2. Building the demo

To build the demo, you just have to run the command:
````
docker compose up
````

## 2.1. Architecture

Two containers will be built: one with IRIS and one with an nginx server. 

![containers](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/containers.png)

We are using the community package csvgen to import the titanic dataset into iris. For the noshow dataset, we use another custom method (the `Load()` classmethod of the `Util.Loader` class). In order for the container to have access to the csv files, we bind the `iris/` local directory to the `/tmp/iris/` directory in the container.

## 2.2. Building the nginx container

In order to build our nginx container, we use multi-stage building. First, we create a container with node. We then install npm and copy all of our files in that container. We build the project with the command `ng build`. The output file is copied in a new container that only contains nginx. 

Thanks to that manoeuvre, we obtain a very light container that does not contain all of the librairies and tools needed to build the webpage. 

You can check the details of that multi-build in the `angular/Dockerfile` file. We also set up our nginx server parameters thanks to the `angular/nginx.default.conf` file.

# 3. Running the demo

Just go to the address: http://localhost:8080/ and That's it! Enjoy!

## 3.1. Exploring both datasets

For both datasets, you'll have access to a complete CRUD, enabling you to modify at will the saved tables. 

In order to switch from one dataset to the other, you can press the button in the top right-hand corner. 

## 3.2. Managing models

### 3.2.1. Creating a model

Once you have discovered the data, you can create model predicting the value you want. 

By pressing in the side navigation menu `Model Manager`, in the `Model List` you'll have access to the following page (here in the case of the NoShow dataset):

![modelList](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelList.png)

You can choose what value you want to predict, the name of your model, and with what variables you want to predict. 

In the side menu, you can toggle `See SQL queries?` to see how the models are managed in IRIS. 

After creating a model you should see this: 

![modelCreated](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelCreated.png)

As you can see, creating a model only takes one SQL query. The informations you have are all the information you can retreive from IRIS. 

In the `actions` column, you can delete a model or purge it. Purging a model will remove all of its training runs (and their validation runs) except for the last one. 

### 3.2.2. Training a model

In the next tab, you will be able to train your models. 

You have the choice between 3 providers. InterSystems' `AutoML`, `H2O`, an open-source solution, and `DataRobot`, of which you can have a  free 14-day trial if you register on their site.

You can select the percentage of the dataset you want to use to train your model. Since it can take a long time to train for large datasets, for the purpose of demonstrations, it is possible to take a smaller dataset.

Here we have trained a model using all of the Titanic Dataset:


![modelTrained](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelTrained.png)

The button in the `actions` column will enable you to see the log. For the AutoML, you will see what the algorithm actually did: how it has prepared the data and how it has chosen the model to use. 

Training a model only takes a single SQL query, as you can see in the messages section of the sidenav menu.

Keep in mind that in these two tabs, you will only see the models that concern the dataset you are actually using.


### 3.2.3. Validating a model

Finally, you can validate a model in the final tab. Clicking on a validation run will pop up a dialog with the metrics associated with the validation. There again, you can choose a percentage of the dataset to use for the validation. 

![modelValidated](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/modelValidated.png)

Once again, it only takes a single SQL query.


### 3.2.4. Making predictions

In the `Make Predictions` menu, last tab, you can make predictions using your newly trained models.

You just have to search for a passenger / patient and select it, select one of the trained model and press predict. 

In the case of a classification model (like in this example, for predicting the survival), the prediction will be associated with the probability of being in the predicted class. 

In the case of Mrs. Fatima Masselmani, the model correctly predicted that she survived, with a probability of 73%. Just below this prediction, you can see the data used by the model:

![prediction](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/prediction.png)

Once again, it takes on query to retreive the prediction and one for the probability.

# 4. Going further

If you want more explainability (more than what the log can offer you), we suggest you using the DataRobot provider. 

For that, you need to go at the address of your DataRobot instance, and look for the `Developer Tools` to get your token. Upon trainnig your model, the webpage will ask you your token. 

Once the training started, you can access your DataRobot instance to know a lot more about your dataset and your models:

![DRdata](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/DRdata.png)

Here, we can see that the `sex` and the `name` fields of every Passenger are the most important values to predict the survival. We can also see that the `fare` field contains outliers.

Once the models trained, you can have access to **a lot** of details, here's a peek: 

![DRmodelDetails](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/DRmodelDetails.png)

# 5. Conclusion

Through this demonstration, we have been able to see how easy it was to create, train and validate a model as well as to predict values through very few SQL queries.

Another goal of this demonstration was to show how it is possible to use a RESTful API together with IntegratedML. 

The front-end has been made with Angular.
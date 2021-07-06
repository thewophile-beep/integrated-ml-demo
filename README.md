# 1. integrated-ml-demo

This repository is a demonstration of integratedML. 

Using a web application, you will be able to create, train and validate the models you want on two datasets, the Titanic and the NoShow datasets. 

The front-end has been done with angular and the back-end with IRIS. 

## 1.1. Building the demo

To build the demo, you just have to run the command:
````
docker compose up
````

### 1.1.1. Architecture

Two containers will be built: one with IRIS and one with an nginx server. 

![FrameworkFull](https://raw.githubusercontent.com/thewophile-beep/integrated-ml-demo/main/misc/img/containers.png)

We are using the community package csvgen to import the titanic dataset into iris. For the noshow dataset, we use another custom method (the `Load()` classmethod of the `Util.Loader` class). In order for the container to have access to the csv files, we bind the `iris/` local directory to the `/tmp/iris/` directory in the container.

### 1.1.2. Building the nginx container

In order to build our nginx container, we use multi-stage building. First, we create a container with node. We then install npm and copy all of our files in that container. We build the project with the command `ng build`. The output file is copied in a new container that only contains nginx. 

Thanks to that manoeuvre, we obtain a very light container that does not contain all of the librairies and tools needed to build the webpage. 

You can check the details of that multi-build in the `angular/Dockerfile` file. We also set up our nginx server parameters thanks to the `angular/nginx.default.conf` file.

## 1.2. Running the demo

Just go to the address: http://localhost:8080/ and That's it! Enjoy!
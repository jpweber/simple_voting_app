# Voting Application 

## Summary

The design of the voting application can be grouped in to two sets of containers. There is the application itself which is comprised of required services and a datastore. The other group is the infrastructure that would normally already exist in your environment but is included here so a fully runnable example is provided. For the purposes of this exercise I will limit the documentation on the app itself and focus more on the infrastructure.

## How to Run

To start up the stack on a single machine in the application repo directory run the following: `docker-compose up` 

or from a directory outside of the repo use `docker-compose -f <path to compose file> up`

### Accessing the application

The voting page can be reached via http://localhost/vote. However the domain name can be whatever you prefer as the front end is configured to listen to any domain. To see the results go to http://localhost/results. 



# Design

The infrascture for this application includes the following components Implemented as containers.

— Ingress reverse Proxy

—  service discovery system and key value store independent of applications ran on cluster.

— service discovery registration

— the application itself including data store

### Ingress Reverse Proxy

For the ingress traffic routing Nginx is being used. The container is based off of nginx 1.11 with added configuration files and dynamic re-configuration tools. The configuration of Nginx is such that it can have a configuration for each virtual host (in our case there is only one) that will dynamically regenerate based on availble services and the IPs of said services. 

The conf file generation and re-generation is facilited by confd (https://github.com/kelseyhightower/confd). 

### Service Discovery

### Service Resgistration



---



## Voting Service
This service is a Node JS service written with Hapi JS. This is where the user
goes to vote. It takes care of writing the votes to the database.

## Result Service
This service is a Python 2 flask service. It takes care of visualizing the
results to the user.

## Database
This application uses Redis as its backing data store.


# Voting Application 

 ![voting diagram](https://github.com/jpweber/simple_voting_app/blob/eval/voting%20diagram.png?raw=true)



## How to Run

To start up the stack on a single machine in the application repo directory run the following: `docker-compose up` 

or from a directory outside of the repo use `docker-compose -f <path to compose file> up`

The docker compose file is made for running the stack all on one machine for demonstration purposes. However all the components are can be ran on a cluster as a distributed system. 

This has been tested against docker server >=1.12 and docker-compose 1.11. The compose file is  a version 3 file.

### Accessing the application

The voting page can be reached via http://localhost/vote. However the domain name can be whatever you prefer as the front end is configured to listen to any domain. To see the results go to http://localhost/results. 

# Design

The infrascture for this application includes the following components Implemented as containers.

* Ingress reverse Proxy

  ​	— nginx

* service discovery system and key value store independent of applications ran on cluster.

  ​	— consul

* service discovery registration

  ​	— registrator

* the application itself including data store

### Ingress Reverse Proxy

For the ingress traffic routing Nginx is being used. The container is based off of nginx 1.11 with dynamic re-configuration tools. Nginx conf files will be gernated by confd when changes occur in consul. Confd uses templates for the conf files then populates values based on those it fetches from consul.

### Service Discovery

Conusl is being used for service discovery in this scenario. Consul provides dns services as well as healthchecks for any services registered with it. The health checks ensure that a dns entry is not created, and entred in to the load balancing pool until the service is healthy. The services will also be removed from load balancing if they become unhealthy. The consul container should be ran on every node of the cluster. The UI for consul can be viewed at http://localhost:8500

### Service Resgistration

Containers are registered witih consul through registrator. Registrator runs on all hosts and listens to the docker.sock file for container start and stops and registers and de-registers accordingly. This also provides health check rules to consul via labels in the docker image or specified at run time. 



## Links to software used

confd - https://github.com/kelseyhightower/confd

consul - https://www.consul.io

registrator - https://github.com/gliderlabs/registrator

nginx http://nginx.org



---



## Voting Service
This service is a Node JS service written with Hapi JS. This is where the user
goes to vote. It takes care of writing the votes to the database.

## Result Service
This service is a Python 2 flask service. It takes care of visualizing the
results to the user.

## Database
This application uses Redis as its backing data store.


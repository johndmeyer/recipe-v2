To build the docker container run `docker build -t <image-name> .`
To build the docker container using a specific docker file run `docker build -t <image-name> -f <dockerfile-name> .`
To run the docker container run `docker run --name <container-name> -p <mapped-port>:<exposed-port> <image-name>`
To stop a docker container `docker stop/kill <container-name>` then `docker rm <container-name>`
To remove an image run `docker image remove <image-name>`

To bind/mount run `docker run --name <container-name>  -p <mapped-port>:<exposed-port> -v $(pwd):usr/src/app -v /usr/src/app/node_modules <image-name>`

To ssh into the docker container run `docker exec -it <container-name>`

To list all the docker images run `docker images`

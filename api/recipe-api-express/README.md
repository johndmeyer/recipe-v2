# Recipe Api Express
- This is an API build as part of my portfolio used to showcase my development skills. It is an API that serves as the middle tier of an application  
that represents a recipe book. Currently this API interfaces with a MongoDb

## Instructions for use:
- Clone the repo to a location of your choice where node is available (v 22 preferred)
- Run `npm i` from the command line to install npm packages
- Run `npm run dev` for development or `npm run start` for production
- Access the OpenApi/Swagger specs at <host>:3000/docs

## Building and running locally with docker

- To build a docker image run `docker build -t <image-name> .` e.g.:
```bash
docker build -t image-recipe-api-express
```

- To run the docker image locally run `docker run --name <container-name> -p <mapped-port>:<exposed-port> <image-name>` e.g.:
```bash
docker run --name container-recipe-api-express -p 80:3000 image-recipe-api-express
```

- Ensure the application runs as expected (e.g. run postman tests to ensure functionality)

## Building and running in AWS
- Build and run the application in docker locally as described above to ensure the image works properly locally

- Ensure that the AWS CLI is installed

- Create an elastic container registry (ECR) via the AWS portal (or command line)

- Retrieve an authentication token and authenticate your Docker client to your registry. Use the AWS CLI:
```bash
aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/o8k8h0m1
```

- Tag the image so you can push the image to this repository:
```bash
docker tag image-recipe-api-express:latest public.ecr.aws/o8k8h0m1/image-recipe-api-express:latest
```

- Push the image up to AWS ECR:
```bash
docker push public.ecr.aws/o8k8h0m1/image-recipe-api-express:latest
```



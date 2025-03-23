# API directions

## To build and run locally
-  `python3 run.py`
- API should show up at http://localhost:5000

## To build and run in docker desktop
- Build a docker image of the application:
```bash
docker build -t image-recipe-api-python-flask .
```

- Run the docker image in docker desktop:
```bash
docker run --name container-recipe-api-python-flask -p 5000:5000 image-recipe-api-python-flask
```

## To build, push and run in GCP
- Follow the steps above to ensure the application runs as expected in a container locally

- Tag and push image to google cloud artifact registry
  - Create registry (if not already existing)
  - `/Volumes/OS/Users/johndmeyer/google-cloud-sdk/bin/gcloud auth login`
  - `docker tag image-recipe-api-python-flask us-central1-docker.pkg.dev/fluid-axe-449221-n2/ar-recipe/image-recipe-api-python-flask`
  - `docker push us-central1-docker.pkg.dev/fluid-axe-449221-n2/ar-recipe/image-recipe-api-python-flask`

- First deployment 
  - Go back to the google cloud console and click 'Deploy an application'
  - Choose the image that was uploaded in the step above
  - Click create
  - Ensure that the database allows the API ip
  - Map domain name to google ips - this was a bit tricky but shouldn't need to be done again (I'll fill this in when I do it again)

- To deploy a new version
  - Follow steps above to tag and push a new image up to google cloud artifact registry
  - Goto cloud run in the google cloud console at choose the existing service image-recipe-ui-vue
  - Click 'Edit & Deploy New Revision'
  - Change the container image to the one just pushed to artifact registry
  - Click deploy
--
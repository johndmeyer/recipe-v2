# Vue 3 + Vite

This template should help get you started developing with Vue 3 in Vite. The template uses Vue 3 `<script setup>` SFCs, check out the [script setup docs](https://v3.vuejs.org/api/sfc-script-setup.html#sfc-script-setup) to learn more.

Learn more about IDE Support for Vue in the [Vue Docs Scaling up Guide](https://vuejs.org/guide/scaling-up/tooling.html#ide-support).

## Docker and GCP Deployment

- Nice video here https://www.youtube.com/watch?v=MM4viHa7k4w

- Build local image:
```bash
docker build -t image-recipe-ui-vue .
```

- Run image locally
```bash
docker run --name container-recipe-ui-vue -p 80:80 image-recipe-ui-vue
```
  - ensure the image runs as expected locally

- Tag and push image to google cloud artifact registry
  - Create registry (if not already existing)
  - `/Volumes/OS/Users/johndmeyer/google-cloud-sdk/bin/gcloud auth login`
  - `docker tag image-recipe-ui-vue us-central1-docker.pkg.dev/fluid-axe-449221-n2/ar-recipe/image-recipe-ui-vue`
  - `docker push us-central1-docker.pkg.dev/fluid-axe-449221-n2/ar-recipe/image-recipe-ui-vue`

- First deployment 
  - Go back to the google cloud console and click 'Deploy an application'
  - Choose the image that was uploaded in the step above
  - Click create
  - Map domain name to google ips - this was a bit tricky but shouldn't need to be done again (I'll fill this in when I do it again)

- To deploy a new version
  - Follow steps above to tag and push a new image up to google cloud artifact registry
  - Goto cloud run in the google cloud console at choose the existing service image-recipe-ui-vue
  - Click 'Edit & Deploy New Revision'
  - Change the container image to the one just pushed to artifact registry
  - Click deploy
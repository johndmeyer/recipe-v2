# RecipeUiAngular

This project was generated using [Angular CLI](https://github.com/angular/angular-cli) version 19.0.5.

## Development server

To start a local development server, run:

```bash
ng serve
```

Once the server is running, open your browser and navigate to `http://localhost:4200/`. The application will automatically reload whenever you modify any of the source files.

## Code scaffolding

Angular CLI includes powerful code scaffolding tools. To generate a new component, run:

```bash
ng generate component component-name
```

For a complete list of available schematics (such as `components`, `directives`, or `pipes`), run:

```bash
ng generate --help
```

## Building

To build the project run:

```bash
ng build
```

This will compile your project and store the build artifacts in the `dist/` directory. By default, the production build optimizes your application for performance and speed.

## Running unit tests

To execute unit tests with the [Karma](https://karma-runner.github.io) test runner, use the following command:

```bash
ng test
```

## Running end-to-end tests

For end-to-end (e2e) testing, run:

```bash
ng e2e
```

Angular CLI does not come with an end-to-end testing framework by default. You can choose one that suits your needs.

## Additional Resources

For more information on using the Angular CLI, including detailed command references, visit the [Angular CLI Overview and Command Reference](https://angular.dev/tools/cli) page.

## Building and running with Docker

Build and run the image locally `docker build -t <image-name> .` then `docker run --name <container-name> -p <mapped-port>:<exposed-port> <image-name>` e.g.:

```bash
docker build -t recipe-ui-angular-image .
docker run --name recipe-ui-angular-container -p 80:80 recipe-ui-angular-image
```

* Ensure the application runs as expected and is pointed at the production (or approprate env) API

## Deploy to Azure

Log into Azure via the CLI:

```bash
az login
```

Build, tag, and push the image to the container registry `az acr build --image <image-name> --registry <container-registry-name> --file <file-path/file-name> .` e.g.:

```bash
az acr build --image recipe-ui-angular-image --registry RecipeUi --file Dockerfile .
```

Deploy updated build. Go to the web app in Azure console and select the Deployment > Deployment Center. Update the image in the image dropdown and save. Return to the main web app page and refresh.



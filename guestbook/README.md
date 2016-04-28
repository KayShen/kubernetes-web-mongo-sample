 Guestbook
==========

This file will be packaged with your application when using `./activator dist`.

## Project structure

### Controllers
- GuestbookController.java:
  Handles guestbook functionality.

- MonitoringController.java:
  Provides a healthcheck.

### Components

- Module.java:
  Shows how to use Guice to bind all the components needed by your application.

## Development
- Build it
`./activator clean compile`
Note: When you run this for the first time - it will download quite a lot of dependencies and will therefor require some time.

- Test it
`./activator test`

- Run it
`./activator run`
The application depends on a running MongoDB to be found at host `mongodb` and port `27017`.
You can change the setting in `conf/application.conf`.

## Deployment
Run `./build.sh` to build the project and create the docker image.
This will call `./activator ;clean;test;stage` and will build the docker 
image according to the Dockerfile (can be found in folder `docker`).

Note: The application only works with a running mongodb (host `mongodb` and port `27017`).
To start a mongodb use:
`docker run -d --name mongodb -p 27017:27017 mongo:3`

You can start the guestbook with:
`docker run -d --name guestbook --link=mongodb:mongodb -p 8080:8080 guestbook` 



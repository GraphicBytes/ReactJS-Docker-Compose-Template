# REACT DOCKER TEMPLATE #

This is a docker template for single page react web apps. This is a completely bare bones "hello world" React.js set up.

### Set up ###

**Edit the .package.json file and update the variables and add your dependencies to suit your project.**

* "name": "**[git repo name]**" 

**Edit the .env file and update the variables to suit your project.**

* COMPOSE_PROJECT_NAME=**[git repo name]**

* HOST_NAME=**[project's production domain]**
* HOST_CONTAINER_NAME=**[git repo name]**
* HOST_CONTAINER_IMAGE=httpd:**[git repo name]**
* HOST_PORT=**[Assign and use a port number used with an Nginx Reverse Proxy ]**

**Edit the .env.react.development file and update the variables to suit your project.**

* PUBLIC_URL=https://192.168.1.66:**[same port as .env file recommended]**
* REACT_APP_API_URL=**[project's development API domain]**

**Edit the .env.react.staging file and update the variables to suit your project.**
* PUBLIC_URL=**[project's staging domain]**
* REACT_APP_API_URL=**[project's development API domain]**

**Edit the .env.react.production file and update the variables to suit your project.**
* PUBLIC_URL=**[project's production domain]**
* REACT_APP_API_URL=**[project's production API domain]**

### Server side boot up ###

Via the command line, goto the root directory of the repo and use the command **"sh tools.sh"** to build or rebuild the docker container, this will also update the environment and rebuild the React App.


### Nginx reverse proxy, SSL and DNS setup ###

This docker container was intended to be used on shared hosting via Nginx Reverse proxy. Use Nginx to handle SSL and DNS pointing to the container's assigned port number
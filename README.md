# What is this repo ❓

This repo contains the Docker configuration for SeeGoals. It sets up both the production and development environments.

# How to run 🚀

To start all the containers, run:

```
docker compose up
```

All the containers will then start running.

To see the website, navigate to the URL displayed in the terminal log after starting the containers. You should see a slight vibration in the robots, indicating that the containers have started as expected.

# Want to code for the AI or the website?

Currently, the ```docker-compose.yaml``` file pulls the code from GitHub. The code is sourced from the main branch (technically, it pulls docker images created from the main branch). If you want to work on the code locally, follow these steps:

1. Clone the repo you wish to develop (e.g., ```controller``` or ```GameViewer```). Ensure your directory structure looks like this:

```
parent_folder
 |- docker (this repo)
 |- controller (or another repo you want to work on)
```

2. Modify the ```docker-compose.yaml``` file to use your local code instead of the code on GitHub. Here```s an example:

Currently:
```
controller:
    image: ghcr.io/liu-seegoals/controller:latest
    ...
```

Change to this:
```
controller:
    build: ../controller 
    volumes:
      - ../controller/:/var/controller
    ...
```
(Note: This step will be streamlined later.)

This change ensures the local code is read. To confirm that this works, run:
```
docker compose build
```
```
docker compose up
```

You should see the same result as before because the local code is identical to the main branch on GitHub.

Now, switch to the branch relevant to your issue and start developing:
```
git checkout your-issue-name-here
```

# Want to configure Docker?

The images are available in the Packages tab of the repo at ```https://github.com/LiU-SeeGoals```. A GitHub Action builds and updates an image with every change in the main branch, as shown in this video: ```https://www.youtube.com/watch?v=RgZyX-e6W9E&list=LL&index=2&t=308s```.

Some images are sourced from ```https://github.com/RoboCup-SSL```. More RoboCup-SSL images will be added later for different configurations.

# What is this repo ❓

This is a repo for seegoals docker config. All the production and development environment are configured from here.


# How to run 🚀

To start all the containers run:
```
docker compose up
```

All the containers are now running.

You can go to the url shown in the terminal log when starting the containers to see the website. You should see a slight vibration on the robots. This means the containers started as expected.

# Do you want to code on the AI or the website?

Currently the `docker-compose.yaml` file pulls the code from github. The code that are pulled are from the main branch (techincally it pulls images from github that are created from main branch). When running the code locally do this:

1. do a `git clone` for the repo you want to develop on i.e `controller` or `GameViewer`. You should have this file structure:
```
parent_folder
 |- docker (this repo)
 |- controller (or another repo you want to develop on)
```
2. Now you need to make a change to the `docker-compose.yaml` file for it to use the local code instead of the code on github. This is an example on how you do it:

This is how it looks now:
```  
controller:
    image: ghcr.io/liu-seegoals/controller:latest
    ...
```

change to this:

```  
controller:
    build: ../controller 
    volumes:
      - ../controller/:/var/controller
    ...
```
(note, above step will be more streamlined later on)

This changes from where the code is read to locally. To verify that this works run:
```
docker compose build
```
```
docker compose up
```

You should now see the exact same result as before the changes, since the the code locally is the main branch of the repo, which is the same as the code on github.

Now change to the branch of the your current issue and start developing
```
git checkout your-issue-name-here
```

# Do you want to configure docker?

The images are hosted on the Packages tab when under in the repo `https://github.com/LiU-SeeGoals`. There is a Github action set up to build an updated image from every change in branch main. This is done according to this video: `https://www.youtube.com/watch?v=RgZyX-e6W9E&list=LL&index=2&t=308s`.

Some of the images used in this project are from `https://github.com/RoboCup-SSL`. More images from `Robocup-SLL` will ned to added later on for different configurations.

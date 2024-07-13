# What is this repo ❓

This repo and README is the starting point for new memebers!

This repo contains the Docker configuration for SeeGoals. It sets up both the production and development environments.

# How to run 🚀

1. Note: this project uses a tool called Docker. Docker can be installed on both linux and windows, but is way easier to work with on linux. If you dont have linux on you computer, it's recomended to work from the lab computer "fetdatorn", and then using the "remote explorer" plugin in vscode. Ask around for help with this setup.

2. Start with cloning this repo to the comuter you decided to work from. Click green button with the text code. Then click ssh. Note: you need to have ssh keys to set this up. If you don't have it follow this [guide](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).

3. It's recomended to keep all SeaGoals related stuff in a folder on your system. Create a folder named `seagoals`

3. Then clone the repo by writing `git clone` and copying the command from previous step. It should look similar to this:

```
git clone git@github.com:LiU-SeeGoals/docker.git
```

4. Then go inside the new folder (repo) called docker `cd docker`. To start all the containers, run:

```
docker compose up
```

All the containers will then start running.

To see the website, navigate to the URL displayed in the terminal log labeld local. You should see a slight vibration in the robots, indicating that the containers have started as expected.

# Want to code for the AI or the website?

Note: it's recomented to have a basic understanding of docker.

Currently, the ```docker-compose.yaml``` file pulls the code from GitHub. The code is sourced from the main branch (technically, it pulls docker images created from the main branch). If you want to work on the code locally, follow these steps:

1. Clone the repo you wish to develop (e.g., ```controller``` or ```GameViewer```). Ensure your directory structure looks like this:

```
parent_folder
 |- docker (this repo)
 |- controller (or another repo you want to work on)
```

2. Modify the ```docker-compose.yaml``` file to use your local code instead of the code on GitHub. Here is an example:

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

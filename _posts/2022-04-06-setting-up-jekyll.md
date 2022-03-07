---
title: Setting up a jekyll site for free using digital ocean and jekyll
author:
  name: Victor Sonck
  link: https://github.com/thepycoder
date: 2022-03-04 18:56:00 +0100
categories: [DevOps]
tags: [Jekyll, DevOps, Docker, Digital Ocean, Cloud]
math: false
mermaid: false
---
# Jekyll with docker on DigitalOcean

Jekyll was a piece of shit to get deployed correctly, so allow me to make it easier.

## Jekyll Dockerfile
This is where all the frustration comes from. Not only is the last jekyll docker image from 8 months ago at the time of writing, there's plenty of annoyances in building the Dockerfile.

```yaml
FROM jekyll/jekyll:4.2.0
# The docker images uses a normal user instead of root (which is good),
# but that also means you can't just put everything in /app because the
# permissions are all fucked up then. Took me a while this one.
COPY . /srv/website
WORKDIR /srv/website
EXPOSE 4000

# Now here's where permissions are fucking in a cryptic way for me.
# Don't know why I need it, but I need it and I hate it.
RUN touch Gemfile.lock
RUN chmod a+w Gemfile.lock
# Install theme dependencies
RUN bundle install
# Same with this junk, if we don't create the folders ourselves,
# stuff crashes on permission errors...
RUN mkdir _site .jekyll-cache
RUN jekyll build
```

## Digital Ocean App Platform
Digital Ocean has a free tier in their app platform that allows you to host 3 static sites for free. It has nice integration with Github, so no need for setting up actions. The only thing we need to do is to create the Dockerfile that generates the static site files and point digital ocean to it!

To get it up and running create a new app and link it to your github or gitlab account. I only allow access to my website repo.

![Step 1](/assets/images/step1.png)

Then select your repo and branch name and leave auto deploy on. This is really handy as it will generate our site and update it every time we push to our selected branch.

![Step 2](/assets/images/step2.png)

In the next step, edit Type and select a static website. Then edit the output folder to the _site of your jekyll folder within the container. Now just choose a name and you should be good to go!

![Step 3](/assets/images/step3.png)

DigitalOcean will build the container every commit to the selected branch and then get all the static files from a specified folder in the container. It will then serve that. Pretty neat!
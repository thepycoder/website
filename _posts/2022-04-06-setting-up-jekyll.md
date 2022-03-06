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

Jekyll was a piece of shit to get deployed correctly, so allow me to make it easier.

## Jekyll Dockerfile
This is where all the frustration comes from. Not only is the last jekyll docker image from 8 months ago at the time of writing, there's plenty of annoyances in building the Dockerfile.

```Docker
# Pick a previous version, because 4+ had issues
FROM jekyll/jekyll:3.8.6
# The docker images uses a normal user instead of root (which is good), but that also means you can't just put everything in /app because the permissions are all fucked up then. Took me a while this one.
RUN git clone https://github.com/thepycoder/website.git /srv/website
WORKDIR /srv/website
EXPOSE 4000

# It cannot handle the Gemfile.lock, it shouldn't be in my git tree, that's on me, but let's remove it anyway.
RUN rm Gemfile.lock
# But it cannot handle it if it isn't there
RUN touch Gemfile.lock
RUN chmod a+w Gemfile.lock

# RUN gem install bundler
RUN bundle install
RUN mkdir _site .jekyll-cache
RUN jekyll build
```

## Digital Ocean App Platform
Digital Ocean has a free tier in their app platform that allows you to host 3 static sites for free. It has nice integration with Github, so no need for setting up actions. The only thing we need to do is to create a Dockerfile that generates the static site files and point digital ocean to it!

To get it up and running create a new app and link it to your github or gitlab account. I only allow access to my website repo.
![Step 1](assets/images/step1.png)

Then select your repo and branch name and leave auto deploy on. This is really handy as it will generate our site and update it every time we push to our selected branch.
![Step 2](assets/images/step2.png)

In the next step, if you added a dockerfile to your jekyll root folder, it will pick it up. Edit Type and select a static website and then edit the output folder to the _site of your jekyll folder within the container.
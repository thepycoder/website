FROM jekyll/jekyll:4.2.0
RUN git clone https://github.com/thepycoder/website.git /srv/website
WORKDIR /srv/website
EXPOSE 4000
RUN bundle install
RUN mkdir _site .jekyll-cache
RUN jekyll build
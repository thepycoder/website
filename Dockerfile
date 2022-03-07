FROM jekyll/jekyll:4.2.0
COPY . /srv/website
WORKDIR /srv/website
EXPOSE 4000

RUN touch Gemfile.lock
RUN chmod a+w Gemfile.lock
RUN bundle install
RUN mkdir _site .jekyll-cache
RUN jekyll build
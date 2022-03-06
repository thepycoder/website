FROM jekyll/jekyll:3.8.6
RUN git clone https://github.com/thepycoder/website.git /home/jekyll/website
WORKDIR /home/jekyll/website
EXPOSE 4000
RUN rm Gemfile.lock
RUN touch Gemfile.lock
RUN chmod a+w Gemfile.lock
RUN gem install bundler
RUN bundle install
CMD bundle exec jekyll build
FROM jekyll/jekyll:4.2.0
COPY . /app
WORKDIR /app
EXPOSE 4000
# RUN ["bundle", "exec", "jekyll", "b"]
RUN ["bundle", "exec", "jekyll", "s"]
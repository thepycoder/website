FROM jekyll/jekyll:4.2.0
COPY . /app
WORKDIR /app
EXPOSE 4000
RUN ["bundle"]
RUN ["mkdir", ".jekyll-cache", "_site", "&&", "bundle", "exec", "jekyll", "b"]
FROM jekyll/jekyll:4.2.0
COPY . /app
WORKDIR /app
EXPOSE 4000
CMD ["jekyll", "build"]
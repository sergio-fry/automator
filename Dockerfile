FROM ruby:3.0.1-slim

WORKDIR /app
ADD . /app/

RUN bundle install

EXPOSE 80
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "80"]

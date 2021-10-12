FROM ruby:3.0.2

WORKDIR /app

ADD Gemfile Gemfile.lock /app/
RUN bundle install

ADD . /app/

EXPOSE 80
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "80"]

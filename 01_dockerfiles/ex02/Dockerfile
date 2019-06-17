FROM ruby
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y nodejs sqlite3

RUN gem install rails

ONBUILD COPY app /opt/app
ONBUILD WORKDIR /opt/app

ONBUILD RUN bundle install
ONBUILD RUN rake db:migrate
ONBUILD RUN rake db:seed


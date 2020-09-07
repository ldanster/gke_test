FROM ruby:2.5.0

RUN apt-get update && apt-get install -y \
  curl \
  build-essential \
  libpq-dev &&\
  curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y nodejs yarn

WORKDIR /usr/src/app

COPY Gemfile* ./

RUN bundle install

COPY . .

RUN npm install webpack -g
RUN webpack install
RUN yarn install

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

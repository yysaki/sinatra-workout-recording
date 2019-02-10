FROM ruby:2.6.0
RUN mkdir /app
COPY Gemfile /app
COPY Gemfile.lock /app
WORKDIR /app
RUN gem install bundler && \
  bundle config build.nokogiri --use-system-libraries && \
  bundle install
  # sqlite3 bbs.db < seeds.sql
COPY . /app
EXPOSE 80
CMD ["/usr/local/bin/ruby", "app.rb", "-p", "80", "-o", "0.0.0.0"]

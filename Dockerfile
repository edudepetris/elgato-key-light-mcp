ARG RUBY_VERSION=4.0.2
FROM ruby:${RUBY_VERSION}-slim
WORKDIR /app
COPY Gemfile Gemfile.lock ./
# irb requires a lot of native C extensions, so we skip it.
RUN bundle config set --local without development && bundle install
COPY . .
CMD ["bundle", "exec", "ruby", "stdio_server.rb"]

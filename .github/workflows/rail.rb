name: Rails

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest

    services:
      postgres:
        image: postgres:latest
        env:
          POSTGRES_USER: postgres
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: todos_test
        ports:
          - 5432:5432
        options: --health-cmd pg_isready --health-interval 10s --health-timeout 5s --health-retries 5

    steps:
    - uses: actions/checkout@v2

    - name: Set up Ruby
      uses: ruby/setup-ruby@v1
      with:
        ruby-version: 2.7

    - name: Set up Node
      uses: actions/setup-node@v2
      with:
        node-version: 14

    - name: Install dependencies
      run: |
        bundle config path vendor/bundle
        bundle install --jobs 4 --retry 3
        yarn install --frozen-lockfile

    - name: Setup test database
      env:
        RAILS_ENV: test
        POSTGRES_USER: postgres
        POSTGRES_PASSWORD: postgres
        PGHOST: localhost
        PGUSER: todos
        PGPASSWORD: password
        POSTGRES_DB: todos_test
      run: bundle exec rails db:create db:schema:load

    - name: Run tests
      env:
        RAILS_ENV: test
      run: bundle exec rails test


# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


## Frontend

```
$ yarn install
```

```
$ yarn run webpack-dev-server --color --mode development
```

``
$ yarn test
``

## Backend

```
$ bundle install
```

```
$ bundle exec rails s -b 0.0.0.0
```

``
$ bundle exec rspec spec
``

## Frontend & Backend


```
$ bundle exec foreman start -f Procfile.dev -p 3000
```

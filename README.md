# README
サンプルアプリ
Rails 6.1 Webpack 4 Vue.js 2.6 VueRouter Vuex Vuetify Jest

## ディレクトリ構成

`/frontend`配下にVue.jsのアプリを配置。

Vue.jsは、Railsのwebpackerではなく、純正のwebpackでビルドされたものを`app/helpers/webpack_bundle_helper.rb`のヘルパーを使って、Railsのテンプレートからincludeされる。

その他のディレクトリ構成は基本的にRailsアプリに準じる。

## 環境構築

* rbenvを使って`.ruby-version`に記載のバージョンのRubyとbundlerをインストール
* Redis、PostgreSQLをインストール

  Dockerを使う場合、以下のdocker-composeファイルを利用可能 (macOSでbrew等をつかって直接インストールしても良い。)
```
$ docker-compose -f docker-compose-redis.yml -f docker-compose-db.yml up -d
```

* Railsアプリ等Rubyライブラリをインストール
```
$ bundle install
```

* DB構築

```
$ bundle exec rails db:create db:migrate db:seed
```

* node.jsのインストール

* Vue.js等、jsライブラリのインストール
```
$ yarn install
```

* Railsサーバーとwebpackサーバーの起動（開発環境）

```
$ bundle exec foreman start -f Procfile.dev -p 3000
```

* 参考:webpackサーバーの単独起動の場合

```
$ yarn run webpack-dev-server --color --mode development
```

* 参考:Railsサーバーの単独起動の場合

```
$ bundle exec rails s -b 0.0.0.0
```

# 単体テスト(Javascript: jest)

```
$ yarn test
```

# 単体テスト(Ruby: rspec)

```
$ bundle exec rspec spec
```

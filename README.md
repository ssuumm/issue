# README

## 初期設定

- docker-compose run --rm api bundle exec rake db:create
- docker-compose run --rm api bundle exec rake db:schema:load


以下のファイルで `pending` 状態になっている4つのテストが通るように実装を修正したいです。
（テストファイルに修正は加えずに）

- spec/models/issue_spec.rb
- spec/requests/issues/index_spec.rb

### テスト実行方法

docker-compose run --rm api bundle exec rspec

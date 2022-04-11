* User model
-------------------------------------------------

|Column              |Type     |Options| | | |
|:----|:----|:----|:----|:----|:----|
|name                 | string | | | | |
|email                | text | | | | |
|password_digest      | string| | | | |
|created_at           | datetime |precision: |6, |null: |FALSE|
|updated_at           | datetime |precision: |6, |null: |FALSE|
|index_users_on_email | indexunique: true| | | |


* Task  model
-------------------------------------------------

|Column              |Type     |Options| | | | |
|:----|:----|:----|:----|:----|:----|:----|
| title                |   string    |null: |FALSE| | | |
| content              |   text      |null: |FALSE| | | |
| created_at           |   datetime  |precision: |6, |null: |FALSE|
| updated_at           |   datetime  |precision: |6, |null: |FALSE|
| index_tasks_on_task  |indexunique: true| | | |
| index_tasks_on_user_id  |indexunique: true| | | |

* Label model
-------------------------------------------------

|Column              |Type     |Options| | | |
|:----|:----|:----|:----|:----|:----|
|task_id|Bigint|null: |FALSE| | |
|name|string|null: |FALSE| | |
|created_at           | datetime |precision: |6, |null: |FALSE|
|updated_at           | datetime |precision: |6, |null: |FALSE|

------------------
Herokuへのデプロイ方法
------------------
1 アプリケーションのルート設定を行います。rootを設定していなかった場合、ドメインURLにアクセスした際、エラー画面が表示されてしまいます
```
$ root 'tops#index'
```  
2. Herokuにログインを実施後 Herokuに新しいアプリケーションを作成します。
```
$ heroku login
$ heroku create
```
3.GemfileのRubyのバージョンをコメントアウトする（Ruby2系を使用している場合）今回はruby '3.0.1'を利用しました。
```
$ ruby '3.0.1'
```
5. git add と git commit 実施します。
```
$ git add.
$ git commit -m "Herokuへデプロイする"
```
6. Heroku buildpack追加します。
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
7. Herokuへデプロイ実施します。
```
$ git push heroku master　#masterブランチからherokuへデプロイする場合
$ git push heroku branch名:master　#branchからherokuへデプロイする場合
```
8. Herokuのデータベースマイグレーション実施
```
$ heroku run rails db:migrate
```
9. Herokuのアプリケーションを起動します。
```
$ heroku open #macのみ
```
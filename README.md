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

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
- has_many :groups_users
- has_many :groups, through: :groups_users


## groups_usersテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :group
- belongs_to :user
- has_many  :messages


## groupsテーブル
|Column|Type|Options|
|------|----|-------|
|groupname|string|null: false|
### Association
- has_many :groups_users
- has_many :users, through: :groups_users


## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|group_user_id|integer|null: false, foreign_key: true|
|body|integer|null: false|
### Association
- belongs_to :groups_users
- belongs_to :image



## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|text|null: false|
|message_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :messages


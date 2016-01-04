class Author < ActiveRecord::Base
  belongs_to :user

  # 多:多の関係
  has_and_belongs_to_many :books

  has_many :comments,   # 関連名 ※テーブル名は fan_comments だが、それとは違う関連名をつけることも可能
           -> { where(deleted: false)}, # 参照条件 ※deleted == false のものだけ検索対象にする
           class_name: 'FanComment',    # テーブル名とは関係ない関連名をつけたので、関連先のクラス名を明示する
           foreign_key: 'author_no'     # 外部キー名もデフォルトの author_id ではないので、ここで明示
end

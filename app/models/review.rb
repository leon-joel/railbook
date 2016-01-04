class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user, counter_cache: true   # 親テーブル側の xxx_count というカラムにレビュー数を記録していく

  # デフォルトスコープでこの条件が必ず適用されるようにしておく
  default_scope { order(updated_at: :desc)}
end

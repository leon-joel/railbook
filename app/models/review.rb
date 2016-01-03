class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user

  # デフォルトスコープでこの条件が必ず適用されるようにしておく
  default_scope { order(updated_at: :desc)}
end

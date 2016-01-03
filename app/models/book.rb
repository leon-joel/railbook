class Book < ActiveRecord::Base
  # 名前付きスコープ（aliasみたいなもの）の定義 (p.210)
  scope :gihyo, -> { where(publish: '技術評論社')}
  scope :newer, -> { order(published: :desc)}
  scope :top10, -> { newer.limit(10)}

  # 引数付きの名前付きスコープも定義できる
  scope :whats_new, ->(pub) {
    where(publish: pub).order(published: :desc).limit(5)
  }

end

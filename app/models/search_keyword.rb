# DBには登録しないがModel機能を使うクラス p.248
class SearchKeyword
  include ActiveModel::Model

  attr_accessor :keyword

  validates :keyword, presence: true
end
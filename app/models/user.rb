class User < ActiveRecord::Base
  # 1対1の関係 ※usersテーブル側には外部キー無し。authersテーブル側にuser_idへの外部キーがある。
  has_one :author

  has_many :reviews
  has_many :books, through: :reviews  # reviewsテーブルを介して、booksへの1対Nアソシエーションを定義

  validates :agreement,
            acceptance: { on: :create }   # 新規作成時のみ許諾確認する
  # validates :email,
  #           confirmation: true,
  #           # presence: { unless: 'dm.blank?'}  # 文字列で条件式を指定する方法
  #           # presence: { unless: :sendmail? }    # シンボルでメソッドを指定する方法
  #           presence: { unless: Proc.new { |u| u.dm.blank? } }  # Procで指定。uにはモデルオブジェクトが入る。

  # 特定の条件を満たす場合のみ検証する。まとめて検証ON/OFFできるから便利。
  with_options unless: 'dm.blank?' do |u|
    u.validates :email, presence: true, confirmation: true
    u.validates :roles, presence: true
  end

  def sendmail?
    dm.blank?
  end
end

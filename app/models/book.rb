class Book < ActiveRecord::Base
  # 1:多 の関係 p.257 ※DBのbooksテーブルにreview_idが入っているのではなくて、reviewsテーブルにbook_idが格納されている
  has_many :reviews   # 複数形

  # 多:多の関係 p.259 ※authorsテーブルの方にも逆向きのアソシエーションが必要（逆向きのアクセスがなければ必要ないかも）
  has_and_belongs_to_many :authors  # もちろん複数形

  # reviewsテーブルを介しての 1:多の関係 を定義
  has_many :users, through: :reviews

  # 検証 p.230
  validates :isbn,
            presence: { message: 'は必須です。' },
            uniqueness: { allow_blank: true, message: '%{value} は一意でなければいけません。' },
            length: { is: 17, allow_blank: true, message: '%{value} は %{count}桁でなければなりません。' }
            # format: { with: /\A[0-9]{3}-[0-9]-[0-9]{3,5}-[0-9]{4}-[0-9X]\z/, allow_blank: true, message: '%{value} は正しい形式ではありません。' }
            # isbn: { allow_old: true }

  # 自作メソッドによる検証 ※Validatorを作るほどの汎用的な検証じゃない場合はこれが便利
  validate :isbn_valid?

  validates :title,
            presence: true,
            # 一意性検証 ※scopeで、「組でユニーク」であることを検証できる。（この場合、出版社が違えば同名タイトルは許される）
            uniqueness: { scope: :publish },
            length: { minimum: 1, maximum: 100 }
  validates :price,
            numericality: { only_integer: true, less_than: 10000 }
  validates :publish,
            inclusion: { in: ['技術評論社', '翔泳社', '秀和システム', '日経BP社', 'ソシム' ]}

  # お手軽に自作validateメソッドで検証
  private
  def isbn_valid?
    errors.add(:isbn, 'は正しい形式じゃねーよ') unless isbn =~ /\A[0-9]{3}-[0-9]-[0-9]{3,5}-[0-9]{4}-[0-9X]\z/
  end


  # 名前付きスコープ（aliasみたいなもの）の定義 (p.210)
  scope :gihyo, -> { where(publish: '技術評論社')}
  scope :newer, -> { order(published: :desc)}
  scope :top10, -> { newer.limit(10)}

  # 引数付きの名前付きスコープも定義できる
  scope :whats_new, ->(pub) {
    where(publish: pub).order(published: :desc).limit(5)
  }

end

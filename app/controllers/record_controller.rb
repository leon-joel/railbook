class RecordController < ApplicationController
  def none
    case params[:id]
      when 'all'
        # http://127.0.0.1:3000/record/none/all
        @books = Book.all
      when 'new'
        # http://127.0.0.1:3000/record/none/new
        @books = Book.order('published DESC').limit(5)
      when 'cheap'
        # http://127.0.0.1:3000/record/none/cheap
        @books = Book.order(:price).limit(5)
      else
        # http://127.0.0.1:3000/record/none
        # @books を nil にすると、テンプレート内でコレクションのeachするときにNilエラーが発生する.
        # Book.noneなら上手くレコード0件を表すことができ、each処理等でエラーにならない。
        @books = Book.none
    end
    render 'books/index'
  end

  # 検索結果を配列で取得
  def pluck
    render text: Book.where(publish: '技術評論社').pluck(:title, :price)
  end

  # 名前付きスコープを使って検索
  def scope
    # @books = Book.gihyo.top10
    @books = Book.whats_new('翔泳社')  # こちらは引数付きのscope
    render 'hello/list'
  end

  # Reviewモデルのデフォルトスコープが適用されているはず。（実際に実行されるSQL文で確認できる）
  def def_scope
    render text: Review.all.inspect
  end

  def count
    # cnt = Book.where(publish: '技術評論社').count    # この出版社が出版している本の数
    cnt = Book.distinct.count(:publish)               # 出版社数
    render text: "#{cnt}件です。"
  end

  def groupby2
    @books = Book.group(:publish).average(:price)
    # 出版社と平均価格のハッシュ（の配列）が返される p.213
  end

  # 生SQLも使える。※但し、特定のDBMSへの依存が強くなるので、生SQLはなるべく避ける
  def literal_sql
    @books = Book.find_by_sql(['SELECT publish, AVG(price) AS avg_price FROM "books" GROUP BY publish HAVING ? <= AVG(price)', 2500])
    # find等普通のメソッドと同様に、結果は bookインスタンスのattributesに格納される（プロパティみたいに使える）
    render 'record/groupby'
  end

  def transact
    Book.transaction do
      b1 = Book.new({isbn: '978-4-7741-4223-0', title: 'Rubyポケットリファレンス',
                     price: 2000, publish: '技術評論社', published: '2011-01-01'})
      b1.save!  # ここでINSERT文が送信される
                # saveは失敗した場合にfalseが返るだけだが、save! を使うと例外が飛ぶので、transaction内で使うにはこの方が便利

      raise '例外発生！処理はキャンセルされました。（b1もキャンセルされていることを確認しましょう。）'

      b2 = Book.new({isbn: '978-4-7741-4223-2', title: 'Tomcatポケットリファレンス',
                     price: 2500, publish: '技術評論社', published: '2011-01-01'})
      b2.save!

    end   # ここでコミット

    render text: 'トランザクションは成功しました。'
  rescue => e
    render text: e.message
  end

  # 検索フォームを表示するためのアクション
  def keywd
    @search = SearchKeyword.new
  end

  # 検索ボタンがクリックされたときに呼び出されるアクション
  def keywd_process
    # 入力値を元にモデルオブジェクトを生成
    @search = SearchKeyword.new(params[:search_keyword])

    # 検証
    if @search.valid?
      render text: @search.keyword
    else
      render text: @search.errors.full_messages[0]
    end
  end

  # belongs_to アソシエーションの確認
  def belongs
    @review = Review.find(3)  # idが3のReviewを取得
  end

  def has_many
    @book = Book.find_by(isbn: '978-4-7741-5878-5')
  end

  def hasone
    @user = User.find_by(username: 'yyamada')
  end

  def has_and_belongs
    @book = Book.find_by(isbn: '978-4-7741-5611-8')
  end

  def has_many_through
    @user = User.find_by(username: 'isatou')
  end

  def cache_counter
    @user = User.find(1)
    render text: @user.reviews.size
  end
end

class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # コントローラー単位でLayoutを指定する場合はこれ(p.171)
  # layout 'product'

  # 指定されていない場合は, views/layouts/コントローラー名.html.erbを採用する。
  # それも存在しない場合は、views/layouts/application.html.erb が使用される。

  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    # 固有のタイトルをLayoutに与える ※与えない場合はデフォルトのタイトルが使用される（ようにLayout側で工夫されている）p.171
    @title = "著書一覧"

    # アクション単位でLayoutを指定する場合はこれ（p.171）
    # render layout: 'sub'
    # Book.allなどの処理より下（おそらくメソッドの最後）に書かないとだめ。@booksがnilになってしまう。
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        # 検証と保存（ISNERT文の実行＆コミット）に成功した場合
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        # renderメソッドの引数で new に対応するテンプレートが呼び出される。※Actionメソッドが実行されるわけではない点に留意。
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      # updateは プロパティ値の上書き ＋ DBへのUPDATE（＝SAVE） を行う
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      # 一覧画面へのリダイレクト ※books_urlはヘルパーメソッド
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      # headメソッドは返すべきcontentがない場合に、HTTPステータスのみを通知するメソッド
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:isbn, :title, :price, :publish, :published, :cd)
    end
end

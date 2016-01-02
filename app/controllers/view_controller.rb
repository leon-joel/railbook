class ViewController < ApplicationController
	def form_tag
    @book = Book.new 
  end

  def form_for
    @book = Book.new
  end

  def field
    @book = Book.new
  end

  def html5
    @book = Book.new
  end

  def select
    @book = Book.new(publish: '技術評論社')
  end

  def col_select
    @book = Book.new(publish: '技術評論社')
    @books = Book.select(:publish).distinct
  end

  def adopt
    render layout: 'sub'
  end

  def multi
    render layout: 'layout'   # layout.html.erb を適用する ※複数contentのLayout
  end

  def nest
    @msg = "今日もいい天気だ"

    render layout: 'child'
  end

  def partial_basic
    @book = Book.find(2)
  end

  def partial_param
    @book = Book.find(3)
  end

  def partial_col
    @books = Book.all
  end
end

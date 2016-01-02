#coding: utf-8

class HelloController < ApplicationController
  def index
    render text: 'こんにちは、世界！'
  end

  def view
    @msg = 'こんにちは、世界だ！'
    # render 'hello/special'
  end

  def list
    @books = Book.all
  end

  def app_var
    # TODO: URLがテキストで表示されるだけなので、実際に画像が表示されるようにする
    #       ※rake notes コマンドで TODO, FIXME, OPTIMIZE を一覧で表示してくれる
    render text: MY_APP['logo']['source']

  end
end

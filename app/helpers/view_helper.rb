module ViewHelper

  # 自作ViewHelperのサンプル
  # すべてのViewHelperは同じ名前空間（ViewHelper）にばらまかれるため、
  # 名前のバッティングが発生する危険性があるので注意。

  # その危険を避けるために、
  # 以下を Application.rb に入れておくと、該当Controllerに対応するViewHelperしかLoadされない。p.165
  # config.action_controller.include_all_helpers = false

  # datetime: 整形対象の日付時刻値（Timeオブジェクト）
  # type : 出力形式（日付時刻 :datetime, 日付のみ :date、時刻のみ :time）
  def format_datetime(datetime, type = :datetime)

    # datetime引数がnilの場合はから文字列を返す
    return '' unless datetime

    case type
      when :datetime
        format = '%Y年%m月%d日 %H:%M:%S'
      when :date
        format = '%Y年%m月%d日'
      when :time
        format = '%H:%M:%S'
      else
        return ''
    end

    datetime.strftime(format)
  end

  # HTML文字列を返すViewHelper (p.166)
  # content_tagを使うことで、適切にエスケープ処理される、タグはそのまま出力されるなどのメリットがある。
  # @return [string] HTML文字列
  # @param [Object配列] collection リストのものになるオブジェクト配列
  # @param [string] prop 一覧するプロパティ名
  def list_tag(collection, prop)
    content_tag(:ul) {
      collection.each { |element|
        concat content_tag(:li, element.attributes[prop])
      }
    }
  end

  # 他の文書からの引用を表すBlockquoteを出力するHelper (p.168)
  # captureはtemplateを受け取り、出力結果を返す標準ヘルパー(p.161)
  def blockquote_tag(cite, citetext, options = {}, &block)
    options.merge! cite: cite

    quote_tag = content_tag(:blockquote, capture(&block), options)
    p_tag = content_tag(:p) do
      concat '出典：'
      concat content_tag(:cite, citetext)
    end
    quote_tag.concat(p_tag)
  end

  def blockquote_tag2(cite, citetext, body = '', options = {}, &block)
    options.merge! cite: cite
    quote_tag = content_tag(:blockquote,
                            block_given? ? capture(&block) : body,
                            options)
  end
end

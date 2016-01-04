# 自作Validator p.243
# 必ずEachValidatorを継承する。
class IsbnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # :allow_old パラメータを受け取り
    if options[:allow_old]
      pattern = '\A([0-9]{3}-)?[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z'
    else
      pattern = '\A[0-9]{3}-[0-9]{1}-[0-9]{3,5}-[0-9]{4}-[0-9X]{1}\z'
    end
    record.errors.add(attribute, 'は正しい形式ではありません。') unless value =~ /#{pattern}/
  end
end
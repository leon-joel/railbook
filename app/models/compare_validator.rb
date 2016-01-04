class CompareValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    # :compare_toパラメータで指定されたフィールドの値を取得
    cmp = record.attributes[options[:compare_to]].to_i

    case options[:type]
      when :greater_than
        record.errors.add(attribute, 'は指定項目より大きくなければいけません。') unless value > cmp
      when :less_than
        record.errors.add(attribute, 'は指定項目より小さくなければなりません。')unless value < cmp
      when :equal
        record.errors.add(attribute, 'は指定項目と等しくなければなりません。')unless value == cmp
      else
        raise 'unknown type'
    end
  end
end
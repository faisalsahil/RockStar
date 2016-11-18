class JsonValidator < ActiveModel::EachValidator


  def validate_each(record, attribute, value)
    begin
      !!JSON.parse(value)
    rescue Exception => e
      record.errors.add(attribute, options[:message], exception_message: e.message)
    end
  end

end
class OrValidator
  pattr_initialize :validators

  def valid?(record)
    validators.any? do |validator|
      validator.valid?(record)
    end
  end

  def message
    @message ||= validators.map(&:message).
      to_sentence(:two_words_connector => " or ", :last_word_connector => ", or ")
  end
end

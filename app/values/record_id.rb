class RecordID
  pattr_initialize :id

  def old?
    id.start_with?("oregondigital:")
  end

  def value
    id.gsub(/^oregondigital:/, '')
  end
end

class EnrichesSolr < SimpleDelegator
  def save(*args)
    if result = super
      EnrichDocumentJob.perform_later(self.id)
    end
    result
  end
end

##
# Decorator to queue enrichment of the solr document after an asset is
# sucessfully saved.
class EnrichesSolr < SimpleDelegator
  def save(*args)
    if result = super
      EnrichDocumentJob.perform_later(self.id)
    end
    result
  end

  # Required to not mess up SimpleForm's path helpers.
  def class
    __getobj__.class
  end
end

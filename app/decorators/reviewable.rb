class Reviewable < SimpleDelegator
  delegate :reviewed=, :to => :workflow_metadata

  def class
    __getobj__.class
  end

  def attributes=(attributes)
    if attributes["needs_reviewed"] == "1"
      self.reviewed = false
    elsif attributes["needs_reviewed"] == "0"
      self.reviewed = true
    end
    super(attributes.except("needs_reviewed"))
  end

  def public?
    read_groups.include?('public')
  end

  def public=(val)
    if val == true
      self.read_groups |= ['public']
    elsif val == false
      self.read_groups -= ['public']
    end
  end

  def reviewed?
    !!workflow_metadata.reviewed
  end

  def needs_reviewed
    !reviewed?
  end
end

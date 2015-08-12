class Reviewable < SimpleDelegator
  delegate :reviewed=, :to => :workflow_metadata

  def class
    __getobj__.class
  end

  def attributes=(attributes)
    if attributes["reviewed"] == "1"
      self.reviewed = false
    elsif attributes["reviewed"] == "0"
      self.reviewed = true
    end
    super(attributes.except("reviewed"))
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

  def reviewed
    reviewed?
  end
end

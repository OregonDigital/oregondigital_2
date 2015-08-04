class Reviewable < SimpleDelegator
  delegate :reviewed=, :to => :workflow_metadata

  def class
    __getobj__.class
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

end

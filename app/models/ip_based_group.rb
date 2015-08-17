class IpBasedGroup < ActiveRecord::Base
  belongs_to :role
  validate :has_valid_ip_addresses

  def self.for_ip(ip)
    ip_int = ip_to_i(ip)
    if ip_int
      joins(:role).where('ip_start_i <= ? AND ip_end_i >= ?', ip_int, ip_int).pluck(:name)
    else
      []
    end
  end

  def ip_start
    @ip_start ||= self.class.i_to_ip(ip_start_i)
  end

  def ip_end
    @ip_end ||= self.class.i_to_ip(ip_end_i)
  end

  def ip_start=(val)
    @ip_start = val
    self.ip_start_i = self.class.ip_to_i(val)
  end

  def ip_end=(val)
    @ip_end = val
    self.ip_end_i = self.class.ip_to_i(val)
  end

  def has_valid_ip_addresses
    if @ip_start && !ip_start_i
      errors.add(:ip_start, "must be a valid IP address")
    end

    if @ip_end && !ip_end_i
      errors.add(:ip_end, "must be a valid IP address")
    end
  end

  private

  # Wraps NetAddr.i_to_ip to simplify failure cases into a single result of nil
  def self.i_to_ip(ip)
    begin
      NetAddr.i_to_ip(ip)
    rescue
      nil
    end
  end

  # Wraps NetAddr.ip_to_i to simplify failure cases into a single result of nil
  def self.ip_to_i(ip)
    begin
      NetAddr.ip_to_i(ip)
    rescue
      nil
    end
  end
end

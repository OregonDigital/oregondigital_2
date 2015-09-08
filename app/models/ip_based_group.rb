class IpBasedGroup < ActiveRecord::Base
  belongs_to :role
  validate :has_valid_ip_addresses

  def self.for_ip(ip)
    ip_int = IpConverter.ip_to_i(ip)
    if ip_int
      joins(:role).where('ip_start_i <= ? AND ip_end_i >= ?', ip_int, ip_int).pluck(:name)
    else
      []
    end
  end

  def ip_start
    @ip_start ||= IpConverter.i_to_ip(ip_start_i)
  end

  def ip_end
    @ip_end ||= IpConverter.i_to_ip(ip_end_i)
  end

  def ip_start=(val)
    @ip_start = val
    self.ip_start_i = IpConverter.ip_to_i(val)
  end

  def ip_end=(val)
    @ip_end = val
    self.ip_end_i = IpConverter.ip_to_i(val)
  end

  def has_valid_ip_addresses
    if @ip_start && !ip_start_i
      errors.add(:ip_start, :invalid)
    end

    if @ip_end && !ip_end_i
      errors.add(:ip_end, :invalid)
    end
  end
end

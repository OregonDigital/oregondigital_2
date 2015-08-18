##
# A simple service for wrapping the NetAddr IP address conversions to suppress
# specific errors and just let us know if we have a valid value or nil
class IpConverter
  def self.i_to_ip(ip)
    begin
      NetAddr.i_to_ip(ip)
    rescue
      nil
    end
  end

  def self.ip_to_i(ip)
    begin
      NetAddr.ip_to_i(ip)
    rescue
      nil
    end
  end
end

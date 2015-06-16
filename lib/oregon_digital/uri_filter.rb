#This object takes a string and makes a decision on whether that string is a uri
#or is a basic string. If it is a uri, the object returns nil, otherwise,
#returns the value that was passed to it. 

module OregonDigital
  class URIFilter

    def initialize(value, uri_detector)
      @value = value
      @uri_detector = uri_detector
    end

    def filter
      return nil if is_uri?
      @value
    end

    def is_uri?
      @uri_detector.new(@value).uri?
    end
  end
end

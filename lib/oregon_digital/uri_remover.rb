module OregonDigital
  class URIRemover

    attr_reader :value

    def initialize(value)
      @value = value
    end

    def to_s
      return remove_uri if self.link_present?
      @value
    end

    def link_present?
      @value.include?("http")
    end

    private

    def remove_uri
      @value.split("$").first
    end
  end
end

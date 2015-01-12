module OregonDigital::Derivatives
  class MediumImageDerivativeRunner < ImageDerivativeRunner

    private

    def size
      "680x680>"
    end

    def success_method
      :medium_success
    end

  end
end

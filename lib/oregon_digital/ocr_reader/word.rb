module OregonDigital
  module OCRReader
    class Word
      def initialize(word)
        @word = word
      end

      def to_s
        @word.text
      end
    end
  end
end

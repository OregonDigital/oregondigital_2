module OregonDigital
  module OCRReader
    class Page
      attr_reader :page_number

      def initialize(page, page_number)
        @page = page
        @page_number = page_number
      end

      def words
        extracted_words.map{ |word| Word.new(word) }
      end

      def stringified_words 
        words.map(&:to_s)
      end

      private

      def extracted_words
        @page.css("word")
      end
    end
  end
end

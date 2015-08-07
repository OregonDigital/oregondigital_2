module OregonDigital
  module OCRReader
    class Page
      attr_reader :page_number

      def initialize(page, page_number)
        @page = page
        @page_number = page_number
      end

      def words
        @word_array = []
        @words = extracted_words.each do |word| 
          @word_array << Word.new(word).to_s
        end
        @word_array
      end

      private

      def extracted_words
        @page.css("word")
      end
    end
  end
end

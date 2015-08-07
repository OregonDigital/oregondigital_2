module OregonDigital
  module OCRReader
    class Reader

      def initialize(content)
        @content = content
      end

      def pages
        @page_array = []
        @pages = extracted_pages.each_with_index do |page, index|
          @page_array << Page.new(page, index + 1)
        end
        @page_array
      end 

      def words
        @word_array = []
        pages.each do |page|
          page.words.each do |word|
            @word_array << word.to_s
          end
        end
        @word_array
      end

      private

      def extracted_pages
        Nokogiri::HTML(@content).css("page")
      end

    end
  end
end

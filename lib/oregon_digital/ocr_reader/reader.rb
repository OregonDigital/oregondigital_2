module OregonDigital
  module OCRReader
    class Reader

      def initialize(content)
        @content = content
      end

      def pages
        extracted_pages.each_with_index.map{ |page, index| Page.new(page, index+1) }
      end 

      def words
        pages.map(&:words).flatten
      end

      def stringified_words
        words.map(&:to_s)
      end

      private

      def extracted_pages
        Nokogiri::HTML(@content).css("page")
      end

    end
  end
end

module OregonDigital::Derivatives::Runners
  class RunnerList
    include Enumerable
    delegate :each, :length, :to => :list
    attr_accessor :list
    def initialize(list)
      @list = list
    end

    def run(asset)
      list.each do |runner|
        runner.run(asset)
      end
    end
  end
end

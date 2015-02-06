module OregonDigital::Derivatives::Runners
  class RunnerList
    attr_accessor :list
    def initialize(list)
      @list = list
    end

    def run(stream, callbacks)
      list.each do |runner|
        runner.run(stream, callbacks)
      end
    end
  end
end

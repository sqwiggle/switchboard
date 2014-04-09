module Switchboard
  class Route

    attr_reader :key, :processor

    def initialize(key, processor)
      @key, @processor = key, processor
    end

    def trigger(data)
      events(data).map { |event| event.trigger }
    end

    def events(data)
      #force to array to allow for singular events, syntactic sugar :)
      Array(processor.call(data))
    end

  end
end

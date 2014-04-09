module Switchboard
  class Router
    include Singleton
    attr_accessor :adapter

    def self.adapter=(val)
      self.instance.adapter = val
    end

    def self.routes
      self.instance.routes
    end

    def self.route(key, &block)
      routes << Route.new(key, block)
    end

    def self.get(key)
      routes.select { |route| route.key == key }
    end
    
    def self.define(&block)
      yield(self)
    end

    def routes
      @routes ||= []
    end

  end
end

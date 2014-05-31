module Switchboard
  class Router
    include Singleton
    attr_accessor :default_adapter

    def self.default_adapter=(val)
      self.instance.default_adapter = val
    end

    def self.routes
      self.instance.routes
    end

    def self.route(key, &block)
      routes << Route.new(key, block)
    end

    def self.get(key)
      routes.select { |route| route.key == key }.tap do |route|
        raise RouteNotFoundError if route.empty?
      end
    end

    def routes
      @routes ||= []
    end

    def clear!
      #this method just makes testing easier
      #perhaps a smell that the singleton complicates the code
      #the singleton definitely keeps the DSL sharp though
      self.default_adapter = nil
      @routes = []
    end

  end
end

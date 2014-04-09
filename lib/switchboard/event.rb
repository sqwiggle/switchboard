module Switchboard
  class Event
    attr_accessor :key, :channel_id, :socket_id, :data

    def initialize(key:nil, channel_id:nil, socket_id:nil, data:nil)
      @key, @channel_id, @socket_id, @data = key, channel_id, socket_id, data
    end

    def adapter
      Router.instance.adapter.new
    end

    def trigger
      adapter.fire! self
    end
  end
end

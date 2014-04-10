module Switchboard
  class Event
    attr_accessor :key, :channel_id, :socket_id, :data, :adapter

    def initialize(key:nil, channel_id:nil, socket_id:nil, data:nil, adapter:Switchboard.router.default_adapter)
      @key, @channel_id, @socket_id, @data, @adapter = key, channel_id, socket_id, data, adapter
    end

    def trigger
      adapter.fire! self
    end
  end
end

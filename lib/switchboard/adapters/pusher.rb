module Switchboard
  module Adapters
    class Pusher

      def self.fire!(event)
        ::Pusher[event.channel_id].trigger(event.key, event.data, event.socket_id)
      end

    end
  end
end

require "singleton"
require "switchboard/version"
require "switchboard/route_not_found_error"
require "switchboard/router"
require "switchboard/route"
require "switchboard/event"
require "switchboard/adapters/pusher"

module Switchboard

  def self.trigger(key, data)
    Router.get(key).map { |route| route.trigger(data) }
  end

  def self.config(&block)
    yield Switchboard::Router
  end

  def self.router
    Router.instance
  end

end

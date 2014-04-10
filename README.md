# Switchboard

This is an internal library used at Sqwiggle for notifying external services (think: Pusher, PubNub, Stripe or simple xmpp or http requests) of internal events.
It allows us to define groups of behaviours in an abstracted location and keep data models small. (read as avoid *after_save*)


At the moment it is entirely focussed on our use case, we open sourced it because there was simple no reason to keep it private, if you find it useful or want to add *Adapters* for your use case or service, that would be swell!

## Installation

Add this line to your application's Gemfile:

    gem 'sqwiggle-switchboard', git:git@github.com:sqwiggle/switchboard.git

And then execute:

    $ bundle

## Usage

Events are *routed* to a processor which returns events that are then fired. 

The routing is defined in an initializer (config/initializers/switchboard.rb)

```Ruby

Switchboard.config do |config|

  config.adapter = Switchboard::Adapters::Pusher

  config.route 'message' do |data|
    [
      Switchboard::Event.new(
        key:'message',
        channel_id:'channel', 
        socket_id:data.socket_id, 
        data:data.as_json
      ), Switchboard::Event.new(
        key:'chat_update', 
        channel_id:data.channel_id, 
        socket_id:data.socket_id, 
        data:data.as_json
      )
    ]
  end

  config.route 'user-updated' do |data|
    Switchboard::Event.new(
      key:'user-updated', 
      channel_id:data.channel_name, 
      data:data.as_json
    )
  end
  end
  ```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sqwiggle-switchboard/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

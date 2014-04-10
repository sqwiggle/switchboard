require 'switchboard'

describe Switchboard do
  let(:dummy_event_1){ double('Event 1', trigger:true) }
  let(:dummy_event_2){ double('Event 2', trigger:true) }
  let(:dummy_event_3){ double('Event 3', trigger:true) }

  before do
    Switchboard.router.clear!
    Switchboard.config do |config|
      config.default_adapter = Switchboard::Adapters::Pusher

      config.route 'route_key_1' do |data|
        Switchboard::Event.new(key:'event_key', channel_id:'channel_id', data:data.to_json)
      end

      config.route 'route_key_1' do |data|
        Switchboard::Event.new(key:'other_event_key', channel_id:'other_channel_id', data:data.to_json)
      end

      config.route 'route_key_2' do |data|
        [
          Switchboard::Event.new(key:'event_key', channel_id:'channel_id', data:data.to_json),
          Switchboard::Event.new(key:'other_event_key', channel_id:'other_channel_id', other_data:data.to_json)
        ]
      end

      config.route 'single_dummy_event' do |data|
        dummy_event_1
      end

      config.route 'multi_dummy_event' do |data|
        [dummy_event_2, dummy_event_3]
      end
    end
  end
  after { Switchboard.router.clear! }

  describe ".config" do
    specify { Switchboard.router.routes.length.should be == 5 }
    specify { Switchboard.router.routes.first.key.should be == 'route_key_1' }
    specify { Switchboard.router.routes.last.key.should be == 'multi_dummy_event' }
  end

  describe ".trigger" do
    it "calls trigger on a single specified event" do
      dummy_event_1.should receive(:trigger)
      Switchboard.trigger('single_dummy_event', {})
    end

    it "calls trigger on multiple specified events" do
      dummy_event_2.should receive(:trigger)
      dummy_event_3.should receive(:trigger)
      Switchboard.trigger('multi_dummy_event', {})
    end
  end

end

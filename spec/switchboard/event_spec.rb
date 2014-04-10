require 'switchboard'

describe Switchboard::Event do
  describe "#adapter" do
    context "with a specified adapter" do
      let(:dummy_adapter) { double('Dummy Adapter') }
      subject { Switchboard::Event.new(adapter:dummy_adapter) }
      its(:adapter) { should be == dummy_adapter }
    end

    context "with the default adapter" do
      Switchboard.config do |config|
        config.default_adapter = Switchboard::Adapters::Pusher
      end
      subject { Switchboard::Event.new }
      its(:adapter) { should be == Switchboard::Adapters::Pusher }
    end
  end

  describe "#trigger" do
    let(:dummy_adapter) { double('Dummy Adapter', fire!:true) }
    subject { Switchboard::Event.new(adapter:dummy_adapter) }
    it "calls fire! on the adapter" do
      dummy_adapter.should receive('fire!').with(subject)
      subject.trigger
    end
  end
end

require 'switchboard'

describe Switchboard::Route do

  let(:data) { 'abc' }

  describe "#events" do
    let(:single_return_processor) { Proc.new { |data| data.upcase } }
    let(:multi_return_processor) { Proc.new { |data| [data.upcase]*2 } }
    context "with a processor that returns a single item" do
      subject { Switchboard::Route.new('key', single_return_processor) }
      specify { subject.events(data).should be == ['ABC'] }
    end
    context "with a processor that returns multiple items" do
      subject { Switchboard::Route.new('key', multi_return_processor) }
      specify { subject.events(data).should be == ['ABC', 'ABC'] }
    end
  end

  describe "#trigger" do
    let(:event_1) { double('Event 1', trigger:true) }
    let(:event_2) { double('Event 2', trigger:true) }
    subject { Switchboard::Route.new('key', processor) }

    context "with a processor that returns a single item" do
      let(:processor) { Proc.new { event_1 } }
      it "calls trigger on the event" do
        event_1.should_receive(:trigger)
        subject.trigger(data)
      end
    end
    context "with a processor that returns multiple items" do
      let(:processor) { Proc.new { [event_1, event_2] } }
      it "calls trigger on the events" do
        event_1.should_receive(:trigger)
        event_2.should_receive(:trigger)
        subject.trigger(data)
      end
    end
  end
end

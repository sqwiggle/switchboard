require 'switchboard'

describe Switchboard::Router do

  describe '.route' do
    let(:processor) { Proc.new { 'hump de bump' } }
    before do
      Switchboard.router.clear!
      Switchboard::Router.route 'key', &processor
    end
    after { Switchboard.router.clear! }
    specify { Switchboard.router.routes.length.should be == 1 }
    specify { Switchboard.router.routes.first.key.should be == 'key' }
    specify { Switchboard.router.routes.first.processor.call.should be == 'hump de bump' }
  end
end

require 'spec_helper'
describe('ntp', :type => :class) do

  describe 'when called with no parameters' do

    it {

      should compile

      should contain_package('ntp').with({
        'ensure' => 'present',
      })

    }

  end
end

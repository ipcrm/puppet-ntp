require 'spec_helper_acceptance'

describe 'ntp class' do

    context 'default parameters' do
    case fact('osfamily')
      when 'RedHat', 'CentOS'
        servicename = 'ntpd'
      when 'Ubuntu', 'Debian'
        servicename = 'ntp'
    end

    # Using puppet_apply as a helper
    it 'should apply with no errors' do
      pp = <<-EOS
      class { 'ntp': }
      EOS

      apply_manifest(pp, :catch_failures => true)
    end

    describe package('ntp') do
      it { is_expected.to be_installed }
    end

    describe file("/etc/ntp.conf") do
      it { should be_file }
      it { should contain("tinker panic 0") }
    end

    describe service(servicename) do
      it { is_expected.to be_running }
    end
  end
end

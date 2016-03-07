require 'spec_helper_acceptance'
describe 'ntp class' do
  it "applies" do
    agent = only_host_with_role(hosts, 'frictionless')
    run_agent_on(agent)
  end
  describe file("/etc/ntp.conf") do
    it { should be_file }
    it { should contain("tinker panic 0") }
  end
  describe service("ntp") do
    it { should be_running }
    it { should be_enabled }
  end
end

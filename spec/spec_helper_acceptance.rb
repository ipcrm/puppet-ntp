require 'beaker-rspec/spec_helper'
require 'beaker-rspec/helpers/serverspec'
require 'beaker/puppet_install_helper'

RSpec.configure do |c|
  # Project root
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
    # Install module and dependencies
    hosts.each do |host|
      if host['roles'].include?('master')
        # Install a master
        agent = only_host_with_role(hosts, 'frictionless')
        master = only_host_with_role(hosts, 'master')
        ENV["PUPPET_INSTALL_TYPE"]='pe'
        run_puppet_install_helper
        copy_module_to(host, :source => proj_root, :module_name => 'ntp')
        on master, "echo '*' > /etc/puppetlabs/puppet/autosign.conf"
        pp = "node \"#{agent}\" { include ntp }"
        on master, "echo '#{pp}' >> /etc/puppetlabs/code/environments/production/manifests/site.pp"
      else
        # Install an agent
        master = only_host_with_role(hosts, 'master')
        ENV["PUPPET_INSTALL_TYPE"]='agent'
        pp = "server = #{master}"
        on host, "mkdir -p /etc/puppetlabs/puppet"
        run_puppet_install_helper
        on host, "echo '#{pp}' >> /etc/puppetlabs/puppet/puppet.conf"
      end
    end
end

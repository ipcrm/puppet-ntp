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
        ENV["PUPPET_INSTALL_TYPE"]='pe'
        run_puppet_install_helper
        copy_module_to(host, :source => proj_root, :module_name => 'ntp')
      end
    end
end

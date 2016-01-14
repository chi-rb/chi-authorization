require 'test_helper'
require 'rails/generators'
require 'generators/abilities/install_generator'

class GeneratorsTest < Rails::Generators::TestCase
  tests Abilities::InstallGenerator
  destination Rails.root.join('tmp')

  teardown do
    FileUtils.rm_rf self.destination_root
  end

  test 'initializer generator' do
    run_generator
    assert_file 'config/abilities.rb'
  end

end
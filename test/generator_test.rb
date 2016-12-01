require 'test_helper'
require 'rails/generators'
require 'generators/abilities/install_generator'

class GeneratorsTest < Rails::Generators::TestCase
  destination Rails.root.join('tmp')

  teardown do
    FileUtils.rm_rf destination_root
  end

  test 'install' do
    self.class.tests Abilities::InstallGenerator
    run_generator
    assert_file 'config/abilities.rb'
  end

end

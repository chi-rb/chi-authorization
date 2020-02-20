require 'test_helper'
require 'rails/generators'
require 'generators/chi/authorization/install/install_generator'

class GeneratorsTest < Rails::Generators::TestCase
  destination Rails.root.join('tmp')

  teardown do
    FileUtils.rm_rf destination_root
  end

  test 'install' do
    self.class.tests Chi::Authorization::Generators::InstallGenerator
    run_generator
    assert_file 'config/initializers/authorization.rb'
    assert_file 'config/authorization.rb'
  end

end

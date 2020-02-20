Rails.application.configure do
  config.cache_classes = false
  config.eager_load = false
  config.consider_all_requests_local = true
  config.active_support.deprecation = :log
  config.active_record.migration_error = :page_load
  config.action_controller.perform_caching = false
  config.cache_store = :null_store
  config.log_level = :debug

  config.assets.debug = true
  config.assets.quiet = true

  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
end

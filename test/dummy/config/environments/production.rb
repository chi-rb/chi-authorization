Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.read_encrypted_secrets = true
  config.serve_static_files = false
  config.action_mailer.perform_caching = false
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.active_record.dump_schema_after_migration = false

  config.log_formatter = Logger::Formatter.new
  config.log_level = :debug
  config.log_tags = [ :request_id ]

  config.assets.js_compressor = :uglifier
  config.assets.compile = false
end

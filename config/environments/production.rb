Rails.application.configure do
  config.cache_classes = true

  config.eager_load = true

  config.consider_all_requests_local = false

  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?

  config.assets.compile = false

  config.active_storage.service = :local

  config.force_ssl = true

  config.log_level = :debug

  config.log_tags = [ :request_id ]

  if ENV["MEMCACHEDCLOUD_SERVERS"]
    config.cache_store = :dalli_store,
      ENV["MEMCACHEDCLOUD_SERVERS"].split(","),
      {
        username: ENV["MEMCACHEDCLOUD_USERNAME"],
        password: ENV["MEMCACHEDCLOUD_PASSWORD"]
      }
  end

  config.action_mailer.perform_caching = false

  config.action_mailer.raise_delivery_errors = true

  config.action_mailer.delivery_method = :smtp

  host = "livelogapp.herokuapp.com"

  config.action_mailer.default_url_options = {host: host}

  config.action_mailer.smtp_settings = {
    address: "smtp.gmail.com",
    port: "587",
    authentication: :plain,
    user_name: ENV["GMAIL_USERNAME"],
    password: ENV["GMAIL_PASSWORD"],
    domain: "gmail.com",
    enable_starttls_auto: true
  }

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end

  config.active_record.dump_schema_after_migration = false
end

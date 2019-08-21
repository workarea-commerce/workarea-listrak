Workarea.configure do |config|
  config.listrak = ActiveSupport::Configurable::Configuration.new

  config.listrak.analytics = {
    merchant_id: nil,
    email_capture_ids: nil
  }
end

OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '238949279785607', '2843d907ed606d42155b85b01696947'
end
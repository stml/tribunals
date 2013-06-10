require 'carrierwave/orm/activerecord'

Fog.credentials = {
  aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'] || 'bogus',
  aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || 'bogus',
  region: 'eu-west-1'
}

CarrierWave.configure do |config|
  config.fog_credentials = { provider: 'AWS' }
  config.fog_directory = 'tribunals.cjs.gov.uk'
  config.fog_attributes = {
    'Cache-Control' => 'max-age=315576000',
    'Content-Disposition' => 'attachment'
  }
  config.fog_use_ssl_for_aws = false
end
CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    S3_ENV = YAML.load_file("#{::Rails.root}/config/aws_cred.yml")[Rails.env]	 
    config.storage    = :aws
    config.aws_bucket = S3_ENV['S3_BUCKET_NAME']
    config.aws_acl    = :public_read
    config.asset_host = 'http://localhost:3000'
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

    config.aws_credentials = {
      access_key_id:     S3_ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: S3_ENV['AWS_SECRET_ACCESS_KEY']
    }
  # For production, AKA Heroku.
  else
    config.storage    = :aws
    config.aws_bucket = ENV.fetch('S3_BUCKET_NAME')
    config.aws_acl    = :public_read
    config.asset_host = 'http://everythingiscollateral.herokuapp.com'
    config.aws_authenticated_url_expiration = 60 * 60 * 24 * 365

    config.aws_credentials = {
      access_key_id:     ENV.fetch('AWS_ACCESS_KEY_ID'),
      secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY')
    }
  end
 
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
end
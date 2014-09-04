CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    S3_ENV = YAML.load_file("#{::Rails.root}/config/aws_cred.yml")[Rails.env]	 
    
    config.fog_credentials = { 
      :provider               => 'AWS', 
      :aws_access_key_id      => S3_ENV['AWS_ACCESS_KEY_ID'], 
      :aws_secret_access_key  => S3_ENV['AWS_SECRET_ACCESS_KEY'], 
    }
    config.fog_public     = false 
    config.fog_directory = S3_ENV['S3_BUCKET_NAME']

  # For production, AKA Heroku.
  else
    config.fog_credentials = { 
      :provider               => 'AWS', 
      :aws_access_key_id      => ENV['AWS_ACCESS_KEY_ID'], 
      :aws_secret_access_key  => ENV['AWS_SECRET_ACCESS_KEY'], 
    }
    config.fog_public     = false 
    config.fog_directory = ENV['S3_BUCKET_NAME']
  end
 
  config.cache_dir = "#{Rails.root}/tmp/uploads"                  # To let CarrierWave work on heroku
end
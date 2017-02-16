CarrierWave.configure do |config|
  config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => "AKIAIDL5AYFLL34CRDPQ",
      :aws_secret_access_key  => "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",
      :region                 => 'us-west-2' # Change this for different AWS region. Default is 'us-east-1'
  }
  config.fog_directory  = "ror-images"
end

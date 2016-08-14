VCR.configure do |config|
  c.cassette_library_dir = 'spec/vcr'
  c.hook_into :httparty
end
spec = Gem::Specification.new do |s| 
  s.name = 'cyrus_data'
  s.version = '1'
  s.summary = 'Code Exercise'
  s.author = 'Sandy Vanderbleek'
  s.files = Dir['lib/**/*.rb']
  s.executables << 'cyrus_data'
  s.required_ruby_version = '>= 1.9.2'
  s.add_development_dependency 'rake', '~> 0.9.2'
end

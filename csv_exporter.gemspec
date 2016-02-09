$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "csv_exporter/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "csv_exporter"
  s.version     = CsvExporter::VERSION
  s.authors     = ["DrawGun"]
  s.email       = ["drawgunich@gmail.com"]
  s.homepage    = "https://github.com/DrawGun/csv_exporter"
  s.summary     = "Simple solution to export csv file."
  s.description = "Simple solution to export csv file."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "activesupport"
  s.add_development_dependency "pry"
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "local_mail/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "local_mail"
  s.version     = LocalMail::VERSION
  s.authors     = ["weih"]
  s.email       = ["imwillmouse@gmail.com"]
  s.homepage    = "https://github.com/weih/local_mail"
  s.summary     = "TODO: Summary of LocalMail."
  s.description = "TODO: Description of LocalMail."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "letter_opener", "~> 1.0"

  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
end

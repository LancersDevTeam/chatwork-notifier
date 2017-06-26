require File.expand_path("../lib/chatwork-notifier/version", __FILE__)

Gem::Specification.new do |s|
  s.name          = "chatwork-notifier"
  s.version       = Chatwork::Notifier::VERSION
  s.platform      = Gem::Platform::RUBY

  s.summary       = ""
  s.description   = ""
  s.authors       = ["peara"]
  s.email         = [""]
  s.homepage      = ""
  s.license       = "MIT"

  s.files         = Dir["{lib}/**/*.rb"]
  s.require_path  = "lib"
end

# frozen_string_literal: true

require_relative "lib/rails_custom_logging/version"

Gem::Specification.new do |spec|
  spec.name          = "rails_custom_logging"
  spec.version       = RailsCustomLogging::VERSION
  spec.authors       = ["Christopher Cocchi-Perrier"]
  spec.email         = ["cocchi.c@gmail.com"]

  spec.summary       = "Replace Rails' verbose logs with anything you like"

  spec.description   = <<~DESC
  Replace Rails' verbose logs with anything you like, from one-liner keys/values to even more verbose logging (it you think that's possible).
  DESC

  spec.homepage      = "https://github.com/ccocchi/rails_custom_logs"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.5.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\Atest/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 6.0", "< 8"
  spec.add_dependency "actionpack", ">= 6.0", "< 8"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end

require_relative 'lib/la_hikes/version'

Gem::Specification.new do |spec|
  spec.name          = "la_hikes"
  spec.version       = LaHikes::VERSION
  spec.authors       = ["Diane Crame"]
  spec.email         = ["dcrame@icloud.com"]

  spec.summary       = "Hikes in Angeles National Forest"
  spec.description   = "Provides hikes listed by name, location, and difficulty"
  spec.homepage      = "https://github.com/Dcrame31/la_hikes"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Dcrame31/la_hikes"
  spec.metadata["changelog_uri"] = "https://github.com/Dcrame31/la_hikes"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
  spec.add_development_dependency "rspec", "~> 3.2"
end

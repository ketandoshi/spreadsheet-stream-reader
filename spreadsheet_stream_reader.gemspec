# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spreadsheet_stream_reader/version'

Gem::Specification.new do |spec|
  spec.name          = 'spreadsheet_stream_reader'
  spec.version       = SpreadsheetStreamReader::VERSION
  spec.authors       = ['Ketan Doshi']
  spec.email         = ['ketandoshi81@gmail.com']

  spec.summary       = %q{Memory efficient spreadsheet reader.}
  spec.description   = %q{Memory efficient spreadsheet reader. It reads file in streaming fashion. Currently supports Excel legacy file (.xls) format. Work in progress for other file formats.}
  spec.homepage      = 'https://github.com/ketandoshi/spreadsheet-stream-reader'
  spec.license       = 'MIT'

  # # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise 'RubyGems 2.0 or newer is required to protect against ' \
  #     'public gem pushes.'
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_runtime_dependency 'spreadsheet', '~> 1.1', '>= 1.1.5'
end

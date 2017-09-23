# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'find_by_sql_paginately/version'

Gem::Specification.new do |spec|
  spec.name          = 'find_by_sql_paginately'
  spec.version       = FindBySqlPaginately::VERSION
  spec.authors       = ['james']
  spec.email         = ['james@rubify.com']

  spec.summary       = %(Add pagination to original Rails find_by_sql function)
  spec.description   = %(Add pagination to original Rails find_by_sql function)
  spec.homepage      = 'http://jameshuynh.com'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.15'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end

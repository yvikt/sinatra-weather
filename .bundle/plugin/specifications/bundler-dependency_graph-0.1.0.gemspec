# -*- encoding: utf-8 -*-
# stub: bundler-dependency_graph 0.1.0 ruby lib

Gem::Specification.new do |s|
  s.name = "bundler-dependency_graph".freeze
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Kerri Miller".freeze, "Whitney-Rose Levis".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-02-17"
  s.description = "A bundler plugin that generates a visual representation of your gem dependencies.".freeze
  s.email = ["kerrizor@kerrizor.com".freeze, "whitney@nird.us".freeze]
  s.homepage = "https://github.com/kerrizor/bundler-dependency_graph".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.8".freeze
  s.summary = "Generate a visual representation of your gem dependencies.".freeze

  s.installed_by_version = "3.0.8" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.14"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
  end
end

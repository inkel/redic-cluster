# encoding: utf-8

Gem::Specification.new do |s|
  s.name              = "redic-cluster"
  s.version           = "0.0.5"
  s.summary           = "Redis Cluster support for Redic"
  s.description       = "Redis Cluster support for Redic, the lightweight Redis client"
  s.authors           = ["Leandro López"]
  s.email             = ["inkel.ar@gmail.com"]
  s.homepage          = "http://inkel.github.com/redic-cluster"
  s.license           = "MIT"

  s.files             = `git ls-files`.split("\n")

  s.add_dependency   "redic"
end

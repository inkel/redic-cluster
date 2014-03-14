# redic-cluster

Redis Cluster support for Redic

## Description

Adds Redis Cluster support for [redic][redic], the lightweight
[Redis][redis] client.

[redic]: https://github.com/amakawa/redic
[redis]: http://redis.io/documentation

## Usage

```ruby
require "redic/cluster"

# Connect to a node in the cluster
node = Redic::Cluster.new("redis://localhost:12001")

# Use the same as you
redis.call("SET", "foo", "bar")
redis.call("GET", "foo")
```

`Redic::Cluster` will transparently follow the redirection to the node
that allocates the slot where `foo` exists. If the `debug` property is
set to `true`, `Redic::Cluster` will inform the redirection in
`$stderr`:

```ruby
require "redic/cluster"

# Connect to a node in the cluster
node = Redic::Cluster.new("redis://localhost:12001")

# Enable redirections log
node.debug = true

# Use the same as you
redis.call("SET", "foo", "bar")
# Will print in $stderr
#   -> Redirected to slot [12182] located at 127.0.0.1:12004
```

## Instalation

You can install it using rubygems.

```
$ gem install redic-cluster
```

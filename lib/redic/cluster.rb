require "redic"

class Redic::Cluster
  attr :url
  attr :node
  attr_accessor :debug

  def initialize(url="redis://localhost:12001", timeout=10_000_000)
    @url   = url
    @node  = Redic::Client.new(url, timeout)
    @debug = false
  end

  def call(*args)
    res = @node.connect do
      @node.write(args)
      @node.read
    end

    return res unless res.is_a?(RuntimeError)

    parts = res.message.split

    if parts.first == "MOVED"
      slot, addr = parts[1,2]

      $stderr.puts "-> Redirected to slot [#{slot}] located at #{addr}" if @debug

      @node.call("QUIT")

      @node = Redic::Client.new("redis://#{addr}", @node.timeout)

      call(*args)
    else
      res
    end
  end
end

require "redic"

class Redic::Cluster
  attr :url
  attr :node
  attr_accessor :debug

  def initialize(url="redis://localhost:12001", timeout=10_000_000)
    @url   = url
    @node  = Redic.new(url, timeout)
    @debug = false
  end

  def call(*args)
    res = @node.call(*args)

    return res unless res.is_a?(RuntimeError)

    parts = res.message.split

    if parts.first == "MOVED"
      slot, addr = parts[1,2]

      $stderr.puts "-> Redirected to slot [#{slot}] located at #{addr}" if @debug

      @node.call("QUIT")

      @node = Redic.new("redis://#{addr}", @node.timeout)

      call(*args)
    else
      res
    end
  end

  def queue(*args)
    @node.queue(*args)
  end

  def commit
    @node.commit
  end
end

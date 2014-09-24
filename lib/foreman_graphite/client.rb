class ForemanGraphite::Client
  attr_reader :client

  def initialize(opts = {})
    GraphiteAPI::Logger.logger = opts[:logger] if opts[:logger]

    @client = GraphiteAPI.new(
      :graphite => (opts[:server] || "0.0.0.0:2003"), # required argument
      :prefix   => ['theforeman', fqdn], # add example.prefix to each key
      :slice    => (opts[:slice] || 60), # results are aggregated in 60 seconds slices
      :interval => (opts[:interval] || 60), # send to graphite every 60 seconds
      :cache    => (opts[:cache] || 4 * 60 * 60) # set the max age in seconds for records reanimation
    )
  end

  def fqdn
    @fqdn ||= (Facter.value(:fqdn) || SETTINGS[:fqdn]).tr(".", "-")
  end

end
class ForemanGraphite::Client
  attr_reader :client

  def initialize(opts = {})
    GraphiteAPI::Logger.logger = opts[:logger] if opts[:logger]

    @client = GraphiteAPI.new(
      :graphite => (opts[:server] || "0.0.0.0:2003"), # required argument
      :prefix   => ['theforeman', fqdn]
    )
  end

  def fqdn
    @fqdn ||= (Facter.value(:fqdn) || SETTINGS[:fqdn]).tr(".", "-")
  end

end
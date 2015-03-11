module ForemanGraphite
  class Engine < ::Rails::Engine
    initializer "setup_graphite", :after => :finisher_hook do |app|
      Foreman::Plugin.register :foreman_graphite do
        requires_foreman '> 1.6'
      end
    end

    initializer 'setup_notifications' do
      opts = {:logger => Rails.logger}
      opts.merge!(SETTINGS[:graphite]) if SETTINGS[:graphite]
      @graphite = ForemanGraphite::Client.new(opts).client
      ActiveSupport::Notifications.subscribe /process_action.action_controller/ do |*args|
        event      = ActiveSupport::Notifications::Event.new(*args)
        controller = event.payload[:controller]
        action     = event.payload[:action]
        format     = event.payload[:format] || "all"
        format     = "all" if format == "*/*"
        status     = event.payload[:status]
        key        = "#{controller}.#{action}.#{format}"
        ActiveSupport::Notifications.instrument :performance, :action => :timing, :measurement => "#{key}.total_duration", :value => event.duration
        ActiveSupport::Notifications.instrument :performance, :action => :timing, :measurement => "#{key}.db_time", :value => event.payload[:db_runtime]
        ActiveSupport::Notifications.instrument :performance, :action => :timing, :measurement => "#{key}.view_time", :value => event.payload[:view_runtime]
        ActiveSupport::Notifications.instrument :performance, :measurement => "#{key}.status.#{status}"
      end

      def send_event_to_graphite(name, payload)
        # action = payload[:action] || :increment
        measurement = payload[:measurement]
        value       = payload[:value]
        key_name    = "#{name.to_s.capitalize}.#{measurement}"

        timeout(3) do
          @graphite.metrics key_name => (value || 1)
        end
      rescue => e
        Rails.logger.warn "Failed to communicate with graphite: #{e}"
      end

      ActiveSupport::Notifications.subscribe /performance/ do |name, start, finish, id, payload|
        send_event_to_graphite(name, payload)
      end
    end
  end
end

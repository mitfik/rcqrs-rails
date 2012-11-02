module Rcqrs
  class Gateway
    include Singleton

    def self.apply(command)
      instance.dispatch(command)
    end

    # Dispatch command to the bus within a transaction
    def dispatch(command)
      @repository.transaction do
        @command_bus.dispatch(command)
      end
    end

  private

    def initialize
      @repository = create_repository
      @command_bus = create_command_bus
      @event_bus = create_event_bus
      wire_events
    end

    # publish raised domain events
    def wire_events
      @repository.on(:domain_event) {|source, event| @event_bus.publish(event) }
    end

    def create_repository
      EventStore::DomainRepository.new(EventStore.create)
    end

    def create_command_bus
      Bus::CommandBus.new(Bus::CommandRouter.new, @repository)
    end

    def create_event_bus
      Bus::EventBus.new(Bus::EventRouter.new)
    end

  end
end

module Rcqrs
  class Gateway
    include Singleton
    include Eventful

    def self.publish(command)
      instance.dispatch(command)
    end
    
    # Dispatch commands to the bus within a transaction
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

    # Dispatch raised domain events
    def wire_events
      @repository.on(:domain_event) {|source, event| @event_bus.dispatch(event) }
    end
    
    def create_repository
      EventStore::DomainRepository.new(create_event_storage)
    end
    
    def create_command_bus
      Bus::CommandBus.new(Bus::CommandRouter.new, @repository)
    end

    def create_event_bus
      Bus::EventBus.new(Bus::EventRouter.new)
    end
    
    def create_event_storage
      case Setting.default_orm 
        when :data_mapper
          raise NotImplementedError, "Not implemented yet, needed adapter for data mapper"
        when :active_record
          config = YAML.load_file(File.join(Rails.root, 'config/event_storage.yml'))[Rails.env]
          EventStore::Adapters::ActiveRecordAdapter.new(config)
        when :in_memory
          EventStore::Adapters::InMemoryAdapter.new 
        else
          raise "This ORM is not supported yet: #{Setting.default_orm}, try use :data_mapper, :active_record or :in_memory"
      end
    end
  end
end

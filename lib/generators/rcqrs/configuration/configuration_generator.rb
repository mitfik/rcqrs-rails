require 'rails/generators'

module Rcqrs
  class ConfigurationGenerator < Rails::Generators::Base
  	source_root File.expand_path('../../../../../example', __FILE__)
  
    def create_event_storage_db_config_file
			copy_file "event_storage.yml", "config/event_storage.yml"
    end

    def create_rcqrs_directories
      empty_directory_with_gitkeep "app/commands"
      empty_directory_with_gitkeep "app/commands/handlers"
      empty_directory_with_gitkeep "app/domain"
      empty_directory_with_gitkeep "app/events"
      empty_directory_with_gitkeep "app/events/handlers"
    end
  
    def create_rcqrs_autoload_paths_initializer
			copy_file "rcqrs.rb", "config/initializers/rcqrs.rb"
    end

    private 
      def empty_directory_with_gitkeep(destination, config = {})
        empty_directory(destination, config)
        create_file("#{destination}/.gitkeep") unless options[:skip_git]
      end
  end
end


require 'rails/generators'

module Rcqrs
    class InstallGenerator < Rails::Generators::Base
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
        @snippet = <<CODE
# include command, events, handlers and domain classes in the application auto load paths
ActiveSupport::Dependencies.autoload_paths += %W(
  #\{Rails.root.to_s\}/app/commands
  #\{Rails.root.to_s\}/app/commands/handlers
  #\{Rails.root.to_s\}/app/domain
  #\{Rails.root.to_s\}/app/events
  #\{Rails.root.to_s\}/app/events/handlers
)

# Rcqrs::Setting.set |setting|
#   setting.default_orm = :data_mapper # You can also use :active_record, :in_memory, :data_mapper
#   setting.default_database_file_path = "config/event_storage.yml"
# end
CODE

        initializer 'rcqrs.rb', @snippet
      end

      private

      def empty_directory_with_gitkeep(destination, config = {})
        empty_directory(destination, config)
        create_file("#{destination}/.gitkeep") unless options[:skip_git]
      end 

    end
end


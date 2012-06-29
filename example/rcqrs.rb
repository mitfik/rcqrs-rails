# include command, events, handlers and domain classes in the application auto load paths
ActiveSupport::Dependencies.autoload_paths += %W(
  "#{Rails.root.to_s}/app/commands"
  "#{Rails.root.to_s}/app/commands/handlers"
  "#{Rails.root.to_s}/app/domain"
  "#{Rails.root.to_s}/app/events"
  "#{Rails.root.to_s}/app/events/handlers"
)
# Rcqrs::Setting.set |setting|
#   setting.default_orm = :data_mapper # You can also use :active_record, :in_memory, :data_mapper
#   setting.default_database_file_path = "config/event_storage.yml"
# end

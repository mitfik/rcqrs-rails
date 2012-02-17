# RCQRS Rails 3 Plugin

Use the [RCQRS](https://github.com/slashdotdash/rcqrs) library in your Rails 3 web app.

## Usage

Add the following dependencies to your Rails app's Gemfile and then `bundle install`

    gem "rcqrs"
    gem "rcqrs-rails"

### Automatic
Use rails g rcqrs:install 

### Manual

Add the following snippet inside `application_controller.rb` (ensuring it is `protected`) to allow each of your controllers to publish commands.

  protected:
    def publish(command)
      Rcqrs::Gateway.publish(command)
    end

Create a yaml config file with your event storage configuration named `config/event_storage.yml` (or copy the example from `example/event_storage.yml`).

Add the following paths to your `application.rb` file `autoload_paths` configuration
    config.autoload_paths += %W(
								  #{config.root}/app/commands
								  #{config.root}/app/commands/handlers
								  #{config.root}/app/domain
								  #{config.root}/app/events
								  #{config.root}/app/events/handlers
								  #{config.root}/app/validators
								  #{config.root}/lib
								)

##Generators

This plugin provides three generators to ease common tasks for generating commands, events and controllers using the CQRS pattern.

* rcqrs:command
* rcqrs:event
* rcqrs:install
* rcqrs:domain

Usage is `rails g rcqrs:command <command name>`
         `rails g rcqrs:event <event_name>`
         `rails g rcqrs:domain <domain name>`
         `rails g rcqrs:install

## Setting

There is possibility to configure rcqrs-rails. Right now there is just 2 options: orm and file path for example:

  Rcqrs::Setting.set do |setting|
    setting.default_orm = :in_memory 
    setting.default_database_file_path = "config/database_event_store.yml" 
  end 

You can put it for example in config/initializer/rcqrs.rb

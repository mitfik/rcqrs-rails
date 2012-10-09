# RCQRS Rails 3 Plugin

Use the [RCQRS](https://github.com/slashdotdash/rcqrs) library in your Rails 3 web app.

## Usage

Add the following dependencies to your Rails app's Gemfile and then `bundle install`

    gem "rcqrs"
    gem "rcqrs-rails"

Add the following snippet inside `application_controller.rb` (ensuring it is `protected`) to allow each of your controllers to publish commands.

    protected
      def publish(command)
        Rcqrs::Gateway.publish(command)
      end

### Automatic

 Use rails g rcqrs:configuration

 Which will create proper directories for commands, domain, events and add initializer for our rcqrs.

### Manual

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

This plugin provides few generators which will help you to create new commands, events and controllers using the CQRS pattern.

 * rcqrs:command          `rails g rcqrs:command <command name>`
 * rcqrs:event            `rails g rcqrs:event <event_name>`
 * rcqrs:domain           `rails g rcqrs:domain <domain name>`
 * rcqrs:configuration    `rails g rcqrs:configuration`


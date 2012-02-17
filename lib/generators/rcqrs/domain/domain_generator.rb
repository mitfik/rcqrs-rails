require 'rails/generators'

module Rcqrs
  class DomainGenerator < Rails::Generators::NamedBase
    check_class_collision :suffix => 'Domain'
  
    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end

    def create_domain_file
      template 'domain.rb', File.join('app/domain', class_path, "#{file_name}_domain.rb")
    end

  end
end

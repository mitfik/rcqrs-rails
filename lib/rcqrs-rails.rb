class RcqrsRails < Rails::Railtie
  require 'singleton'
  require 'rcqrs/gateway'
  require 'rcqrs/setting'
	require 'rcqrs'
end

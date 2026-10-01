require 'logger'
require 'rubygems'
require 'bundler'
Bundler.setup

require 'mongoid'
models_folder = File.join(File.dirname(__FILE__), 'mongoid/models')
Mongoid.configure do |config|
  name = 'voteable_mongo_test'
  host = 'localhost'
  config.connect_to(name)
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

Mongoid.logger.level = Logger::ERROR
Mongo::Logger.logger.level = Logger::ERROR

require 'voteable_mongo'
require 'rspec'
require 'rspec/autorun'

# RSpec 3 with the RSpec 2-era `should` syntax still enabled, so the existing specs run unchanged.
RSpec.configure do |c|
  c.expect_with(:rspec) { |e| e.syntax = [:should, :expect] }
  c.mock_with(:rspec) { |m| m.syntax = [:should, :expect] }
end

Dir[ File.join(models_folder, '*.rb') ].each { |file|
  require file
  file_name = File.basename(file).sub('.rb', '')
  klass = file_name.classify.constantize
  begin
    klass.collection.drop
  rescue Exception => e
    print e.message
  end
}

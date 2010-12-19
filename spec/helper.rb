$:.unshift(File.expand_path('../../lib', __FILE__))

require 'rubygems'
require 'bundler'

Bundler.require(:default, :development)

require 'hunt'

MongoMapper.connection = Mongo::Connection.new
MongoMapper.database   = 'hunt-test'

Rspec.configure do |c|
  c.before(:each) do
    MongoMapper.database.collections.each(&:remove)
  end
end
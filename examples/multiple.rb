$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require 'pp'
require 'hunt'

MongoMapper.database = 'testing'

class Note
  include MongoMapper::Document
  plugin Hunt

  key :title, String
  key :tags,  Array

  # Declare which fields to search on.
  # No problem declaring an array key.
  searches :title, :tags
end
Note.delete_all # clean the slate

# Note that the search terms are stored in a searches hash in the key default.
# This is so that future versions can allow different combinations of search
# fields and use different keys in searches.

# Also, meaningless words are stripped out and all words less than 3 characters
# long. The words are then stemmed (http://en.wikipedia.org/wiki/Stemming) so
# exact matches when searching are not necessary.

pp Note.create(:title => 'I am lost without Mongo!', :tags => %w(mongo database nosql))
#<Note searches: {"default"=>["test", "mongo", "databas", "nosql"]}, title: "This is a test", _id: BSON::ObjectId('...'), tags: ["mongo", "database", "nosql"]>

pp Note.create(:title => 'Lost is a tv show', :tags => %w(lost tv))
#<Note searches: {"default"=>["lost", "tv", "show"]}, title: "Lost is a tv show", _id: BSON::ObjectId('...'), tags: ["lost", "tv"]>

pp Note.search('lost').count      # 2
pp Note.search('tv').count        # 1

# Multiple words work
pp Note.search('mongo tv').count  # 2
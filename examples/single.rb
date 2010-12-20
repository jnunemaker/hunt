$LOAD_PATH.unshift(File.expand_path('../../lib', __FILE__))
require 'pp'
require 'hunt'

MongoMapper.database = 'testing'

class Note
  include MongoMapper::Document
  plugin Hunt

  key :title, String

  # Declare which fields to search on.
  searches :title
end
Note.delete_all # clean the slate

# Note that the search terms are stored in a searches hash in the key default.
# This is so that future versions can allow different combinations of search
# fields and use different keys in searches.
#
# Also, meaningless words are stripped out and all words less than 3 characters
# long. The words are then stemmed (http://en.wikipedia.org/wiki/Stemming) so
# exact matches when searching are not necessary.

note = Note.create(:title => 'This is a test')
pp note
# #<Note searches: {"default"=>["test"]}, title: "This is a test", _id: BSON::ObjectId('...')>

note.update_attributes(:title => 'A different test')
pp note
# #<Note searches: {"default"=>["differ", "test"]}, title: "A different test", _id: BSON::ObjectId('...')>

# Also, you get a handy
pp Note.search('test').count    # 1
pp Note.search('testing').count # 1
pp Note.search('testing').all
# [#<Note searches: {"default"=>["differ", "test"]}, title: "A different test", _id: BSON::ObjectId('...')>]

pp Note.search('test').paginate(:page => 1)
# [#<Note searches: {"default"=>["differ", "test"]}, title: "A different test", _id: BSON::ObjectId('...')>]
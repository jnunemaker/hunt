require 'helper'

class Note
  include MongoMapper::Document

  plugin Hunt

  key :title, String
  key :body,  String
  key :tags,  Array
end

describe Hunt do
  it "adds searches key to model to store search terms" do
    Note.searches(:title)
    Note.new.should respond_to(:searches)
    Note.new.should respond_to(:searches=)
  end

  context "Searching on one field" do
    before(:each) do
      Note.searches(:title)
      @note = Note.create(:title => 'Woot for MongoDB!')
    end

    let(:note) { @note }

    it "indexes terms on create" do
      note.searches['default'].should == %w(woot for mongodb)
    end

    it "indexes terms on update" do
      note.update_attributes(:title => 'Another woot')
      note.searches['default'].should == %w(another woot)
    end
  end

  context "Searching on multiple fields" do
    before(:each) do
      Note.searches(:title, :body, :tags)
      @note = Note.create(:title => 'Woot for MongoDB!', :body => 'This is my body.')
    end

    let(:note) { @note }

    it "indexes merged terms on create" do
      note.searches['default'].should == %w(woot for mongodb this is my body)
    end

    it "indexes merged terms on update" do
      note.update_attributes(:title => 'Another woot', :body => 'An updated body.')
      note.searches['default'].should == %w(another woot an updated body)
    end
  end

  context "Searching on multiple fields one of which is array key" do
    before(:each) do
      Note.searches(:title, :tags)
      @note = Note.create(:title => 'Woot for MongoDB!', :tags => %w(mongo nosql))
    end

    let(:note) { @note }

    it "indexes merged terms on create" do
      note.searches['default'].should == %w(woot for mongodb mongo nosql)
    end

    it "indexes merged terms on update" do
      note.update_attributes(:title => 'Another woot', :tags => %w(mongo))
      note.searches['default'].should == %w(another woot mongo)
    end
  end
end
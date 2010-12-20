require 'helper'

describe Hunt::Util do
  describe ".strip_puncuation" do
    it "removes punctuation" do
      Hunt::Util.strip_puncuation('woot!').should == 'woot'
    end
  end

  describe ".stem" do
    it "stems word" do
      Hunt::Util.stem('kissing').should == 'kiss'
      Hunt::Util.stem('hello').should   == 'hello'
      Hunt::Util.stem('barfing').should == 'barf'
    end
  end

  describe ".to_words" do
    it "does not fail with nil" do
      Hunt::Util.to_words(nil).should == []
    end

    it "converts string to array of words" do
      Hunt::Util.to_words('first sentence').should == %w(first sentence)
    end

    it "squeezes multiple spaces" do
      Hunt::Util.to_words('first    sentence').should == %w(first sentence)
    end

    it "removes punctuation" do
      Hunt::Util.to_words('woot!').should == %w(woot)
    end

    it "removes blanks from removed punctuation" do
      Hunt::Util.to_words('first sentence & second').should == %w(first sentence second)
    end

    it "lowercases each word" do
      Hunt::Util.to_words('Sweet First Sentence').should == %w(sweet first sentence)
    end

    it "removes any words under 2 characters" do
      Hunt::Util.to_words('a tv show').should == %w(tv show)
    end

    it "removes words that should be ignored" do
      Hunt::Util.to_words('how was your day').should == %w(day)
      Hunt::Util.to_words("didn't you see that").should == %w(see)
    end

    it "removes duplicates" do
      Hunt::Util.to_words('boom boom').should == %w(boom)
    end
  end

  describe ".to_stemmed_words" do
    it "converts value to array of stemmed words" do
      Hunt::Util.to_stemmed_words('I just Caught you kissing.').should == %w(just caught kiss)
    end
  end
end
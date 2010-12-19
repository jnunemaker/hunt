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
    it "converts string to array of words" do
      Hunt::Util.to_words('this is my sentence').should == %w(this is my sentence)
    end

    it "squeezes multiple spaces" do
      Hunt::Util.to_words('this is my  sentence').should == %w(this is my sentence)
    end

    it "removes punctuation" do
      Hunt::Util.to_words('my first sentence.').should == %w(my first sentence)
    end

    it "removes blanks from removed punctuation" do
      Hunt::Util.to_words('my first sentence & second').should == %w(my first sentence second)
    end

    it "lowercases each word" do
      Hunt::Util.to_words('My First Sentence').should == %w(my first sentence)
    end
  end
end
module Hunt
  module Util
    def strip_puncuation(value)
      value.to_s.gsub(/[^a-zA-Z0-9]/, '')
    end

    def stem(word)
      Stemmer.stem_word(word)
    end

    def to_words(value)
      value.
        squeeze(' ').
        split(' ').
        map     { |word| strip_puncuation(word.downcase) }.
        reject  { |word| word.blank? }
    end

    extend self
  end
end
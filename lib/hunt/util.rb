module Hunt
  module Util
    Separator = ' '
    StripPunctuationRegex = /[^a-zA-Z0-9]/
    PunctuationReplacement = ''
    WordsToIgnore = [
      "a", "about", "above", "after", "again", "against", "all", "am", "an",
      "and", "any", "are", "aren't", "as", "at", "be", "because", "been",
      "before", "being", "below", "between", "both", "but", "by", "cannot",
      "can't", "could", "couldn't", "did", "didn't", "do", "does", "doesn't",
      "doing", "don't", "down", "during", "each", "few", "for", "from",
      "further", "had", "hadn't", "has", "hasn't", "have", "haven't", "having",
      "he", "he'd", "he'll", "her", "here", "here's", "hers", "herself", "he's",
      "him", "himself", "his", "how", "how's", "i", "i'd", "if", "i'll", "i'm",
      "in", "into", "is", "isn't", "it", "its", "it's", "itself", "i've", "let's",
      "me", "more", "most", "mustn't", "my", "myself", "no", "nor", "not", "of",
      "off", "on", "once", "only", "or", "other", "ought", "our", "ours", "ourselves",
      "out", "over", "own", "same", "shan't", "she", "she'd", "she'll", "she's",
      "should", "shouldn't", "so", "some", "such", "than", "that", "that's", "the",
      "their", "theirs", "them", "themselves", "then", "there", "there's", "these",
      "they", "they'd", "they'll", "they're", "they've", "this", "those", "through",
      "to", "too", "under", "until", "up", "very", "was", "wasn't", "we", "we'd",
      "we'll", "were", "we're", "weren't", "we've", "what", "what's", "when",
      "when's", "where", "where's",  "which", "while", "who", "whom", "who's",
      "why", "why's", "with", "won't", "would", "wouldn't", "you", "you'd",
      "you'll", "your", "you're", "yours", "yourself", "yourselves", "you've",
      "the", "how"
    ]

    def strip_puncuation(value)
      value.to_s.gsub(StripPunctuationRegex, PunctuationReplacement)
    end

    def stem(word)
      Stemmer.stem_word(word)
    end

    def to_words(value)
      value.
        to_s.
        squeeze(Separator).
        split(Separator).
        map     { |word| word.downcase }.
        reject  { |word| word.size < 2 }.
        reject  { |word| WordsToIgnore.include?(word) }.
        map     { |word| strip_puncuation(word) }.
        reject  { |word| word.blank? }.
        uniq
    end

    def to_stemmed_words(value)
      to_words(value).map { |word| stem(word) }
    end

    extend self
  end
end
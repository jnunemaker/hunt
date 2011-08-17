require 'fast_stemmer'
require 'mongo_mapper'
require 'hunt/util'

module Hunt
  extend ActiveSupport::Concern

  class << self
    def included(model)
      model.before_save(:index_search_terms)
    end

    def configure(&block)
      block.call(self) if block_given?
    end

    def additional_words_to_ignore(words)
      Util.update_words_to_ignore(words) if words.any?
    end
  end

  module ClassMethods
    def search_keys
      @search_keys ||= []
    end

    def searches(*keys)
      # Using a hash to support multiple indexes per document at some point
      key(:searches, Hash)
      ensure_index :'searches.default'
      @search_keys = keys
    end

    def search(term)
      where('searches.default' => Util.to_stemmed_words(term))
    end
  end

  module InstanceMethods
    def concatted_search_values
      self.class.search_keys.map { |key| send(key) }.flatten.join(' ')
    end

    def index_search_terms
      self.searches['default'] = Util.to_stemmed_words(concatted_search_values)
    end
  end
end

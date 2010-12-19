require 'fast_stemmer'
require 'hunt/util'

module Hunt
  def self.configure(model)
    model.before_save(:index_search_terms)
  end

  module ClassMethods
    def search_keys
      @search_keys ||= []
    end

    def searches(*keys)
      key(:searches, Hash)
      @search_keys = keys
    end

    def search(value)
      terms = Util.to_stemmed_words(value)
      return [] if terms.blank?
      where('searches.default' => terms)
    end
  end

  module InstanceMethods
    def search_keys
      self.class.search_keys
    end

    def concatted_search_values
      search_keys.map { |key| send(key) }.flatten.join(' ')
    end

    def index_search_terms
      self.searches['default'] = Util.to_stemmed_words(concatted_search_values)
    end
  end
end
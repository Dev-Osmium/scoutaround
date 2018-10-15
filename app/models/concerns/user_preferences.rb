# Courtesy of http://joshsymonds.com/blog/2012/05/16/quick-and-easy-user-preferences-in-rails/

module UserPreferences
  extend ActiveSupport::Concern

  included do
    has_many :user_preferences
    @@preferences = {}
  end

  module ClassMethods
    def preference(name, default)
      preferences = self.class_variable_get(:'@@preferences')
      preferences[name] = default
      self.class_variable_set(:'@@preferences', preferences)
    end
  end

  def read_preference(name)
    if p = self.user_preferences.where(key: name).first
      return p.value
    end
    return self.user_preferences.new(key: name, value: @@preferences[name]).value if @@preferences.has_key?(name)
    nil
  end

  def write_preference(name, value)
    p = self.user_preferences.find_or_create_by_key(name)
    p.update_attribute(:value, value)
  end

  def method_missing(method, *args)
    if @@preferences.keys.any?{ |k| method =~ /#{k}/ }
      if method =~ /=/
        self.write_preference(method.gsub('=', ''), *args)
      else
        self.read_preference(method)
      end
    else
      super
    end
  end
end

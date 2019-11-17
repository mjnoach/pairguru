class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  cattr_accessor :skip_callbacks
end

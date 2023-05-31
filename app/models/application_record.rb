class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  p @resource
end

# Base class for all database objects.
class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end

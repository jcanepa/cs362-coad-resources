# This is an abstract class that extends ActiveRecord::Base,
# and will be used to instantiate applications for disaster
# resources

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

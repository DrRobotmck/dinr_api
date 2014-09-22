class Restaurant < ActiveRecord::Base
  belongs_to :cuisine
  belongs_to :boro
  has_many :inspections

end

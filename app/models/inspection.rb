class Inspection < ActiveRecord::Base
  belongs_to :action
  has_and_belongs_to_many :violations
  belongs_to :restaurants, dependent: :destroy

end

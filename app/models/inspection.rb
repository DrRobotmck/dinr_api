class Inspection < ActiveRecord::Base
  has_and_belongs_to_many :actions
  has_and_belongs_to_many :violations
  belongs_to :restaurants, dependent: :destroy
end

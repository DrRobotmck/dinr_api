class Restaurant < ActiveRecord::Base
  belongs_to :cuisine
  belongs_to :boro
  has_many :inspections

  def self.fetch(params)
    sanitized_params = self.sanitize_params(params)
    self.where(sanitized_params)
  end
  def self.sanitize_params(params)
    if params.keys.include?('boro')
      params['boro_id'] = Boro.find_by(name: params['boro']).id
      params.delete('boro')
    end
    if params.keys.include?('cuisine')
      params['cuisine_id'] = Cuisine.find_by(description: params).id
      params.delete('cuisine')
    end
    params
  end
end

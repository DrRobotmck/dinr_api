class Restaurant < ActiveRecord::Base
  belongs_to :cuisine
  belongs_to :boro
  has_many :inspections

  def self.fetch(params)
    sanitized_params = self.sanitize_params(params)
    query_results = self.search(sanitized_params)
  end

  def self.sanitize_params(params)
    params.delete('camis') if params.keys.include?('camis')
    if params.keys.include?('boro')
      params['boro_id'] = set_boro(params)
      params.delete('boro')
    end
    if params.keys.include?('cuisine')
      params['cuisine_id'] = set_cuisine(params)
      params.delete('cuisine')
    end
    params[:current_grade].capitalize! if params.keys.include?('current_grade')
    params
  end

  def self.set_boro(params)
    boro = params['boro'].split.map(&:capitalize).join(' ')
    return Boro.find_by(name: boro).id
  end

  def self.set_cuisine(params)
    cuisine = params[:cuisine].downcase
    return Cuisine.find_by('LOWER(description) = ?', cuisine).id
  end
  
  def self.search(params)
    if params.keys.include?('dba')
      all_matches = self.where('LOWER(dba) LIKE ?','%'+params[:dba].downcase+'%')
      params.delete('dba')
      all_matches.where(params)
    else
      self.where(params)
    end
  end
end

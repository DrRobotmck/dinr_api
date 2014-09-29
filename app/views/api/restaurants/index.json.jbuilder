json.response do
  json.data do
    json.array!(@restaurants) do |restaurant|
      json.id restaurant.id
      json.camis restaurant.camis
      json.dba restaurant.dba
      json.building_number restaurant.building_number
      json.street_address restaurant.street_address
      json.zip_code restaurant.zip_code
      json.phone_number restaurant.phone_number
      json.current_grade restaurant.current_grade
      json.boro_code restaurant.boro.identifier if restaurant.boro
      json.boro_name restaurant.boro.name if restaurant.boro
      json.cuisine_code restaurant.cuisine.code
      json.cuisine_type restaurant.cuisine.description
      json.total_inspections restaurant.inspections.count
      json.last_updated restaurant.updated_at
    end
  end
  json.query_params params
end

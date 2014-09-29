xml.response do
  xml.data do
    @restaurants.each.with_index do |restaurant|
      xml.restaurant do
        xml.id restaurant.id
        xml.camis restaurant.camis
        xml.dba restaurant.dba
        xml.building_number restaurant.building_number
        xml.street_address restaurant.street_address
        xml.zip_code restaurant.zip_code
        xml.phone_number restaurant.phone_number
        xml.current_grade restaurant.current_grade
        xml.boro_code restaurant.boro.identifier if restaurant.boro
        xml.boro_name restaurant.boro.name if restaurant.boro
        xml.cuisine_code restaurant.cuisine.code
        xml.cuisine_type restaurant.cuisine.description
        xml.total_inspections restaurant.inspections.count
        xml.last_updated restaurant.updated_at
      end
    end
    xml.query_params do
      params.each do |key, value|
        xml.param "#{key}: #{value}"
      end
    end
  end
end

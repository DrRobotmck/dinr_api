json.response do
  json.data do
    json.restaurant do
      json.id @restaurant.id
      json.camis @restaurant.camis
      json.dba @restaurant.dba
      json.building_number @restaurant.building_number
      json.street_address @restaurant.street_address
      json.zip_code @restaurant.zip_code
      json.phone_number @restaurant.phone_number
      json.current_grade @restaurant.current_grade
      json.boro_code @restaurant.boro.identifier if @restaurant.boro
      json.boro_name @restaurant.boro.name if @restaurant.boro
      json.cuisine_code @restaurant.cuisine.code
      json.cuisine_type @restaurant.cuisine.description
      json.total_inspections @restaurant.inspections.count
      json.inspections(@restaurant.inspections) do |inspection|
        json.date_inspected inspection.date_inspected
        json.score inspection.score
        json.action_code inspection.action.code
        json.action_details inspection.action.description
        json.violations(inspection.violations) do |violation|
          json.(violation, :code, :description, :critical_violation)
        end
      end
      json.last_updated @restaurant.updated_at
    end
  end
  json.params params
end

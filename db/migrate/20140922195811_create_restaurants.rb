class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.integer :camis
      t.string :dba
      t.string :building_number
      t.string :street_address
      t.integer :zip_code
      t.string :phone_number
      t.string :current_grade
      t.date :grade_date
      t.belongs_to :boro
      t.belongs_to :cuisine

      t.timestamps
    end
  end
end

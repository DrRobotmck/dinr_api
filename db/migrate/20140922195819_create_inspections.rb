class CreateInspections < ActiveRecord::Migration
  def change
    create_table :inspections do |t|
      t.date :date_inspected
      t.integer :score
      t.belongs_to :restaurant

      t.timestamps
    end
  end
end

class CreateInspectionsViolations < ActiveRecord::Migration
  def change
    create_join_table :inspections, :violations do |t|
      t.index :inspection_id
      t.index :violation_id
    end
  end
end

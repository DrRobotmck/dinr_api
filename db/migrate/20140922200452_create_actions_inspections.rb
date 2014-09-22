class CreateActionsInspections < ActiveRecord::Migration
  def change
    create_join_table :actions, :inspections do |t|
      t.index :action_id
      t.index :inspection_id
    end
  end
end

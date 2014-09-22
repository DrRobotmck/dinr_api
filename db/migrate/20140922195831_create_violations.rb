class CreateViolations < ActiveRecord::Migration
  def change
    create_table :violations do |t|
      t.string :code
      t.boolean :critical_violation
      t.text :description

      t.timestamps
    end
  end
end

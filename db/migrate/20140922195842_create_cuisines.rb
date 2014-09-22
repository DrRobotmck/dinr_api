class CreateCuisines < ActiveRecord::Migration
  def change
    create_table :cuisines do |t|
      t.string :code
      t.text :description

      t.timestamps
    end
  end
end

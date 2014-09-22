class CreateBoros < ActiveRecord::Migration
  def change
    create_table :boros do |t|
      t.integer :identifier
      t.string :name
    end
  end
end

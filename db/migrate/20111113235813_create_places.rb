class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name
      t.references :trip

      t.timestamps
    end
    add_index :places, :trip_id
  end
end

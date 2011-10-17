class CreateTrips < ActiveRecord::Migration
  def change
    create_table :trips do |t|
      t.string :name
      t.references :user

      t.timestamps
    end
    add_index :trips, :user_id
  end
end

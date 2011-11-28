class AddBegunOnEndedOnToTrips < ActiveRecord::Migration
  def change
    add_column :trips, :begun_on, :date
    add_column :trips, :ended_on, :date
    add_index :trips, [:begun_on, :ended_on]
  end
end

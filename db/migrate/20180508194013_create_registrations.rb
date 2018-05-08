class CreateRegistrations < ActiveRecord::Migration[5.1]
  def change
    create_table :registrations do |t|
      t.integer :event_id
      t.integer :person_id

      t.timestamps
    end
  end
end

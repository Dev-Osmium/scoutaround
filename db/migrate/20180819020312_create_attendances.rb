class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.integer :event_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end
  end
end

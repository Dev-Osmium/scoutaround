class AddPublishedToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :published, :boolean, default: false

    Event.update_all(published: true)
  end
end

class AddThemeToEvents < ActiveRecord::Migration[5.2]
  def change
  	add_column :events, :theme, :string
  end
end

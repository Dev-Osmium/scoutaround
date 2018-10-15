class AddAddressFieldsToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :address, :string
    add_column :events, :city,    :string
    add_column :events, :state,   :string
    add_column :events, :postal_code, :string
  end
end

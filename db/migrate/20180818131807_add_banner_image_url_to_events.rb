class AddBannerImageUrlToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :banner_image_url, :string
  end
end

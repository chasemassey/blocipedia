class AddCategoryIdToWikis < ActiveRecord::Migration
  def change
    add_column :wikis, :category_id, :integer
  end
end

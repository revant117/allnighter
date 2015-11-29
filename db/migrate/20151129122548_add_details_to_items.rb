class AddDetailsToItems < ActiveRecord::Migration
  def change
    add_column :items, :price, :integer
    add_column :items, :ava, :boolean
  end
end

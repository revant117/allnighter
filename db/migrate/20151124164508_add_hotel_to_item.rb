class AddHotelToItem < ActiveRecord::Migration
  def change
    add_reference :items, :hotel, index: true, foreign_key: true
  end
end

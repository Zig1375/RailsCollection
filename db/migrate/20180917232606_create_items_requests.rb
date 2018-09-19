class CreateItemsRequest < ActiveRecord::Migration[5.2]
  def change
    create_table :items_request do |t|
      t.belongs_to :item, index: true
      t.belongs_to :request, index: true
      t.column :state, :integer, default: 1
      t.timestamps
    end
  end
end
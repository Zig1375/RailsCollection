class CreateCategoriesItems < ActiveRecord::Migration[5.2]
  def change
    create_table :categories_items, id: false do |t|
      t.belongs_to :item, index: true
      t.belongs_to :category, index: true
    end
  end
end

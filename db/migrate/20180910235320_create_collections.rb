class CreateCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :collections do |t|
      t.column :title, :string
      t.column :product, :integer, default: 0
      t.column :countImages, :integer, default: 1
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end

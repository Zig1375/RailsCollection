class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.column :title, :string
      t.column :note, :string
      t.column :hiddenText, :text
      t.column :swappable, :boolean, default: false
      t.column :images, :string
      t.references :collection, foreign_key: true
      t.timestamps
    end
  end
end

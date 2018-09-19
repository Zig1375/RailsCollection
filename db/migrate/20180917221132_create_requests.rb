class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.column :name, :string
      t.column :email, :string
      t.column :message, :text
      t.column :state, :integer, default: 1
      t.references :collection, foreign_key: true
      t.timestamps
    end
  end
end

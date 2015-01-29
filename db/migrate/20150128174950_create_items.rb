class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :email
      t.string :title
      t.integer :price
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end

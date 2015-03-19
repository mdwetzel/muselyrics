class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.text :description
      t.integer :year

      t.timestamps null: false
    end
    add_index :albums, :title
  end
end

class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :title
      t.text :lyrics
      t.text :description

      t.timestamps null: false
    end
    add_index :songs, :title
  end
end

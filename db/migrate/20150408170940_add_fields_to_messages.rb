class AddFieldsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :ip, :string
    add_column :messages, :sent_at, :datetime
  end
end

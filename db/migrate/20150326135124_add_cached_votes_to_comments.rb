class AddCachedVotesToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :cached_votes_up, :integer, :default => 0
  	Comment.find_each(&:update_cached_votes)
  end
end

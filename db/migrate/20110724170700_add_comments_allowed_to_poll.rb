class AddCommentsAllowedToPoll < ActiveRecord::Migration
  def self.up
    add_column :polls, :comments_allowed, :boolean
  end

  def self.down
    remove_column :polls, :comments_allowed
  end
end

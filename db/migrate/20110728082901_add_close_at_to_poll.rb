class AddCloseAtToPoll < ActiveRecord::Migration
  def self.up
    add_column :polls, :close_at, :datetime
  end

  def self.down
    remove_column :polls, :close_at
  end
end

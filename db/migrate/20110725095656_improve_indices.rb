class ImproveIndices < ActiveRecord::Migration
  def self.up
    remove_index :entries, [:participant_id, :choice_id]
    add_index :entries, :participant_id
    add_index :entries, :choice_id
    add_index :comments, :poll_id
  end

  def self.down
    remove_index :comments, :poll_id
    remove_index :entries, :choice_id
    remove_index :entries, :participant_id
    add_index :entries, [:participant_id, :choice_id], :unique => true
  end
end

class AddChoiceIdToEntry < ActiveRecord::Migration
  def self.up
    add_column :entries, :choice_id, :integer

    remove_index :entries, :participant_id
    add_index :entries, [:participant_id, :choice_id], :unique => true
  end

  def self.down
    remove_index :entries, [:participant_id, :choice_id]
    add_index :entries, :participant_id

    remove_column :entries, :choice_id
  end
end

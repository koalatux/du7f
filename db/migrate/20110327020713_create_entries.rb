class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :answer
      t.references :participant
    end

    add_index :entries, :participant_id
  end

  def self.down
    remove_index :entries, :participant_id

    drop_table :entries
  end
end

class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants do |t|
      t.string :name
      t.references :poll

      t.timestamps
    end

    add_index :participants, :poll_id
  end

  def self.down
    remove_index :participants, :poll_id

    drop_table :participants
  end
end

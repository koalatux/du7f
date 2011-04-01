class CreatePolls < ActiveRecord::Migration
  def self.up
    create_table :polls do |t|
      t.string :token
      t.string :admin_token
      t.string :author
      t.string :title
      t.text :description
      t.integer :poll_type

      t.timestamps
    end

    add_index :polls, :token, :unique => true
  end

  def self.down
    remove_index :polls, :token

    drop_table :polls
  end
end

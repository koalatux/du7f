class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.string :title
      t.references :poll
    end

    add_index :choices, :poll_id
  end

  def self.down
    remove_index :choices, :poll_id

    drop_table :choices
  end
end

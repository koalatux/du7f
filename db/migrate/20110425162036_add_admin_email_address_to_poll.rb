class AddAdminEmailAddressToPoll < ActiveRecord::Migration
  def self.up
    add_column :polls, :admin_email_address, :string
  end

  def self.down
    remove_column :polls, :admin_email_address
  end
end

class AddFreetimeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :free_time, :string
  end
end

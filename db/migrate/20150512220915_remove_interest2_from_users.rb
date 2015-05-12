class RemoveInterest2FromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :interest2, :string
  end
end

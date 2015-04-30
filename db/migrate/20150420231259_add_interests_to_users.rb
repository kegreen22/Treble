class AddInterestsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zipcode, :string
    add_column :users, :interest1, :string
    add_column :users, :interest2, :string
    
    add_column :users, :password_digest, :string
    add_column :users, :slug, :string

  end
end

class AddConnectionTokenToConnectionRequest < ActiveRecord::Migration
  def change
    add_column :connection_requests, :connection_token, :string
  end
end

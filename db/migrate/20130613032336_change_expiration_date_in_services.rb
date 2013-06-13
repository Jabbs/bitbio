class ChangeExpirationDateInServices < ActiveRecord::Migration
  def change
    remove_column :services, :expiration_date
    add_column :services, :expiration_date, :date
  end
end

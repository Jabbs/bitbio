class ChangeTypeToSomethingInLeads < ActiveRecord::Migration
  def up
    rename_column :leads, :type, :account_type
  end

  def down
    rename_column :leads, :account_type, :type
  end
end

class ChangeTitleToSubjectInMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :title, :subject
  end
end

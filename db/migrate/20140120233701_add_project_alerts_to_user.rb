class AddProjectAlertsToUser < ActiveRecord::Migration
  def change
    add_column :users, :project_alerts, :boolean, default: false
    add_column :users, :blog_alerts, :boolean, default: false
    add_column :users, :event_alerts, :boolean, default: false
  end
end

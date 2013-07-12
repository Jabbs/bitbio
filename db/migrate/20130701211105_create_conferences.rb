class CreateConferencess < ActiveRecord::Migration
  def change
    create_table :conferences do |t|
      t.string :title
      t.string :website
      t.text :description
      t.datetime :start_date
      t.datetime :end_date
      t.string :twitter_handle
      t.string :location_name
      t.string :organizer
      t.string :phone

      t.timestamps
    end
  end
end

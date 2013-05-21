class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :project_id
      t.text :content
      t.string :title

      t.timestamps
    end
    add_index :messages, :sender_id
    add_index :messages, :receiver_id
    add_index :messages, :project_id
  end
end

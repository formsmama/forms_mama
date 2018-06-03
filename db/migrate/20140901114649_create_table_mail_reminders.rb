class CreateTableMailReminders < ActiveRecord::Migration
  def change
    create_table :mail_reminders do |t|

      t.column :user_id, :integer
      t.column :document_id, :integer
      t.timestamps
    end
    execute %{ ALTER TABLE mail_reminders ADD FOREIGN KEY (user_id) REFERENCES users (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
    execute %{ ALTER TABLE mail_reminders ADD FOREIGN KEY (document_id) REFERENCES documents (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
    add_index :mail_reminders, :user_id
    add_index :mail_reminders, :document_id
  end
end

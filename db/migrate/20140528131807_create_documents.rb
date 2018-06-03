class CreateDocuments < ActiveRecord::Migration
  def up
    create_table :documents do |t|

      t.column :template_id, :integer
      t.column :title, :string
      t.column :user_id, :integer
      t.column :session_uniq_token, :string
      t.timestamps
    end
    execute %{ ALTER TABLE documents ADD FOREIGN KEY (template_id) REFERENCES templates (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
    add_index :documents, :user_id
    add_index :documents, :session_uniq_token, :unique => true
    add_index :documents, :template_id
  end

  def down
    drop_table :documents
  end
end

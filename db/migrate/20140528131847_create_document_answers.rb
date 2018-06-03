class CreateDocumentAnswers < ActiveRecord::Migration
  def up
    create_table :document_answers do |t|

      t.column :document_id, :integer
      t.column :template_field_id, :integer
      t.column :answer, :string
      t.timestamps
    end
    execute %{ ALTER TABLE document_answers ADD FOREIGN KEY (document_id) REFERENCES documents (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
    execute %{ ALTER TABLE document_answers ADD FOREIGN KEY (template_field_id) REFERENCES template_fields (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
    add_index :document_answers, [:document_id, :template_field_id], :unique => true
  end

  def down
    drop_table :document_answers
  end
end

class AddTemplateStepIdToDocumentAnswers < ActiveRecord::Migration
  def up
    add_column :document_answers, :template_step_id, :integer
    execute %{ ALTER TABLE document_answers ADD FOREIGN KEY (template_step_id) REFERENCES template_steps (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
    add_index :document_answers, [:template_step_id, :document_id, :template_field_id], :name => :asnwers_fast_index
  end
  def down
    remove_index :document_answers, :name => :asnwers_fast_index
    remove_column :document_answers, :template_step_id
  end
end

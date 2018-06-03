class UpgradeTemplateFields < ActiveRecord::Migration
  def change
    add_column :template_fields, :toggle_id, :integer
    add_column :template_fields, :in_loop, :boolean, :default => false

    remove_index :document_answers, :column => [:document_id, :template_field_id]
  end
end

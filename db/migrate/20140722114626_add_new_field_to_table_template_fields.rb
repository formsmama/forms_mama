class AddNewFieldToTableTemplateFields < ActiveRecord::Migration
  def change
    add_column :template_fields, :amount_field_id, :integer
    add_column :template_fields, :raw_question, :boolean, :default => true
  end
end

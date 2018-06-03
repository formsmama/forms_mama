class AddNewColumnsToTables < ActiveRecord::Migration
  def change
    add_column :template_fields, :sort_index, :string
    add_column :document_answers, :sort_index, :string
    add_column :document_answers, :sort_number, :integer
  end
end

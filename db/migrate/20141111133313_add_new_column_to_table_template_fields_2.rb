class AddNewColumnToTableTemplateFields2 < ActiveRecord::Migration
  def change
    add_column :template_fields, :spouses, :string
  end
end

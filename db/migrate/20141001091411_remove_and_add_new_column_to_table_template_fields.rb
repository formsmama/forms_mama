class RemoveAndAddNewColumnToTableTemplateFields < ActiveRecord::Migration
  def change
    add_column :template_fields, :insert_place, :string
  end
end

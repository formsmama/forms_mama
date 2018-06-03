class AddNewColumnToTableTemplateFields < ActiveRecord::Migration
  def change
    add_column :template_fields, :sub_toggle_id, :integer
  end
end

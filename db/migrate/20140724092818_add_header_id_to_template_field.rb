class AddHeaderIdToTemplateField < ActiveRecord::Migration
  def change
    add_column :template_fields, :header_id, :integer
    add_column :template_fields, :additional_header_id, :integer
  end
end

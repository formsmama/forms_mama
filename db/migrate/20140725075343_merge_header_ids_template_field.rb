class MergeHeaderIdsTemplateField < ActiveRecord::Migration
  def change
    remove_column :template_fields, :header_id, :integer
    remove_column :template_fields, :additional_header_id, :integer
    add_column :template_fields, :header_ids, :string
  end
end

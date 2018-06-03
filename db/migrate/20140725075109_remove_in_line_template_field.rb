class RemoveInLineTemplateField < ActiveRecord::Migration
  def change
    remove_column :template_fields, :in_line, :boolean, :default => false
    remove_column :template_fields, :in_loop, :boolean, :default => false
  end
end

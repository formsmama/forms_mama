class ExpandNameTypeTemplateField < ActiveRecord::Migration
  def change
    change_column :template_fields, :name, :text, :limit => nil
  end
end

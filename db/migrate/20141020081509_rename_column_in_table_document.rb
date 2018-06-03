class RenameColumnInTableDocument < ActiveRecord::Migration
  def change
    rename_column :documents, :title, :template_name
  end
end

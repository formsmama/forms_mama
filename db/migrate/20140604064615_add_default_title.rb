class AddDefaultTitle < ActiveRecord::Migration
  def change
    remove_column :documents, :title, :string
    add_column :documents, :title, :string, :default => 'Untitled document'
  end
end

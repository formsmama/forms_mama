class AddIsGeneratedToDocument < ActiveRecord::Migration
  def change
    add_column :documents, :is_generated, :boolean, :default => false
  end
end

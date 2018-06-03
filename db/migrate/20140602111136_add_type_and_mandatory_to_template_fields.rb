class AddTypeAndMandatoryToTemplateFields < ActiveRecord::Migration
  def change
    add_column :template_fields, :field_type, :string, :default => 'string'
    add_column :template_fields, :mandatory, :boolean, :default => true
  end
end

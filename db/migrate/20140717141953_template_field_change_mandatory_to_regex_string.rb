class TemplateFieldChangeMandatoryToRegexString < ActiveRecord::Migration
  def change
    remove_column :template_fields, :mandatory, :boolean, :default => true
    add_column    :template_fields, :mandatory, :string
  end
end

class AddToggleOptionForRadiobuttonToTemplateFields < ActiveRecord::Migration
  def change
    add_column :template_fields, :toggle_option, :string
  end
end

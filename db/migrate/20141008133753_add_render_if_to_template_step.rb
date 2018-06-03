class AddRenderIfToTemplateStep < ActiveRecord::Migration
  def change
    add_column :template_fields, :render_if_id, :string
    add_column :template_fields, :render_if_value, :string
  end
end

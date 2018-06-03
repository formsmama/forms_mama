class AddSkipOptionsToTemplateStep < ActiveRecord::Migration
  def change

    add_column :template_steps, :render_if_field_id, :integer
    add_column :template_steps, :render_if_field_value, :string
  end
end

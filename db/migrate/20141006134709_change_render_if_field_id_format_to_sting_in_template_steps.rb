class ChangeRenderIfFieldIdFormatToStingInTemplateSteps < ActiveRecord::Migration
  def change
    change_column :template_steps, :render_if_field_id, :string
  end
end

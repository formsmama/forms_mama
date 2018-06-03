class RemoveExcessFields < ActiveRecord::Migration
  def change
    remove_column :document_answers, :created_at
    remove_column :document_answers, :updated_at

    remove_column :template_fields, :order_number, :integer
    add_column :template_fields, :in_line, :boolean, :default => false

    change_column :template_steps, :description, :text, :limit => nil
  end
end

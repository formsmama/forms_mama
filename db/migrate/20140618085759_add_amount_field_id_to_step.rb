class AddAmountFieldIdToStep < ActiveRecord::Migration
  def change
    add_column :template_steps, :amount_field_id, :integer
  end
end

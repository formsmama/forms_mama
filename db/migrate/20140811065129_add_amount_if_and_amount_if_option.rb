class AddAmountIfAndAmountIfOption < ActiveRecord::Migration
  def change
    add_column :template_steps, :amount_field_if, :integer
    add_column :template_steps, :amount_field_if_option, :string
  end
end

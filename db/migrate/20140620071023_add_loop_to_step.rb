class AddLoopToStep < ActiveRecord::Migration
  def change
    add_column :template_fields, :looper_option, :string
    add_column :template_fields, :dont_repeat, :boolean, :default => false
    add_column :document_answers, :toggler_offset, :integer, :default => 0
  end
end

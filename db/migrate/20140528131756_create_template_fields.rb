class CreateTemplateFields < ActiveRecord::Migration
  def up
    create_table :template_fields do |t|

      t.column :template_id, :integer
      t.column :name, :string
      t.column :step_number, :integer
      t.column :order_number, :integer
      t.timestamps
    end
    execute %{ ALTER TABLE template_fields ADD FOREIGN KEY (template_id) REFERENCES templates (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
    add_index :template_fields, [:template_id, :step_number, :order_number], :unique => true, :name => :uniqueness
  end

  def down
    drop_table :template_fields
  end
end
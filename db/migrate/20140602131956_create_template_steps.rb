class CreateTemplateSteps < ActiveRecord::Migration
  def up
    create_table :template_steps do |t|

      t.column :template_id, :integer
      t.column :step_number, :integer
      t.column :title, :string
      t.column :description, :string
    end

    add_index :template_steps, [:template_id, :step_number], :unique => true
    execute %{ ALTER TABLE template_steps ADD FOREIGN KEY (template_id) REFERENCES templates (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }

    remove_column :template_fields, :template_id
    remove_column :template_fields, :step_number

    add_column :template_fields, :template_step_id, :integer
    add_index :template_fields, :template_step_id
    execute %{ ALTER TABLE template_fields ADD FOREIGN KEY (template_step_id) REFERENCES template_steps (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
  end
  def down
    remove_column :template_fields, :template_step_id

    drop_table :template_steps

    add_column :template_fields, :step_number, :string

    add_column :template_fields, :template_id, :integer
    add_index :template_fields, [:template_id, :step_number, :order_number], :unique => true, :name => :uniqueness
    execute %{ ALTER TABLE template_fields ADD FOREIGN KEY (template_id) REFERENCES templates (id) MATCH SIMPLE ON UPDATE CASCADE ON DELETE CASCADE; }
  end
end

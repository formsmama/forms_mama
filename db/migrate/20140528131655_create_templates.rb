class CreateTemplates < ActiveRecord::Migration
  def up
    create_table :templates do |t|

      t.column :name, :string
      t.column :description, :string
      t.timestamps
    end
  end
  def down
    drop_table :templates
  end
end

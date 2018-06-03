class CreateDependentDocuments < ActiveRecord::Migration
  def change
    create_table :dependent_documents do |t|
      t.integer :document_id
      t.integer :sub_document_id

      t.timestamps
    end
  end
end

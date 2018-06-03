class ChangeAnswerTypeField < ActiveRecord::Migration
  def change
    remove_column :document_answers, :answer, :string
    add_column :document_answers, :answer, :text
  end
end

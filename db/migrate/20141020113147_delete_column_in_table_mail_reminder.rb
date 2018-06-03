class DeleteColumnInTableMailReminder < ActiveRecord::Migration
  def change
    remove_column :mail_reminders, :document_id, :integer
    add_column :mail_reminders, :reminder_type, :string
  end
end

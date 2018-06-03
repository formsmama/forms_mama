class MailForm < ActionMailer::Base
  default from: 'forms_mama@example.com'

  helper DivorceComplaintHelper

  REMINDER_TYPE = ['after_download', 'after_finished']

  def reminder_after_download_divorce_complaint(user, document, after_day)
    @document, @day = document, after_day
    mail(to: get_email(user), subject: 'Reminder from www.FormsMama.com')
  end

  def reminder_after_finished_divorce_complaint(user, document, after_day)
    @document, @day = document, after_day
    mail(to: get_email(user), subject: 'Reminder from www.FormsMama.com')
  end

  def get_email(user)
    user.documents.where(:template_name => Document::DIVORCE_COMPLAINT).first.step_answers(3).map(&:answer)[16]
  end

end
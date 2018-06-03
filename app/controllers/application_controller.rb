class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def after_sign_in_path_for(user)
    if !user.documents.present?
      user.documents << Template.where(:name => Document::DIVORCE_COMPLAINT).first.documents.build(:template_name => Document::DIVORCE_COMPLAINT)
      document_answer_path :document_id => user.documents.last.id, :step => 1
    else
      root_path
    end
  end
end

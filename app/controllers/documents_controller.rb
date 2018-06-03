class DocumentsController < ApplicationController

  def create
    document = current_user.create_document params[:template_id]
    current_user.bind_sub_document params[:document_id], document if params[:document_id]
    redirect_to document_answer_path(document.id, 1)
  end
end
class PdfFilesController < ApplicationController
  require 'pdf_documents/pdf'

  before_action :get_user_document, :only => [:generate, :download]
  before_action :get_user_documents, :only => [:index, :welcome]

  def index
    @file_names = Document.get_files_name @documents, current_user
  end

  def welcome
  end

  def generate
    PdfDocument::Pdf.new.generate @document
    @document.update :is_generated => true
    current_user.create_mail_reminder! MailForm::REMINDER_TYPE.second if @document.template_name.eql?(Document::AFTER_SERVICE)
    redirect_to pdf_files_path, :notice => 'Document complete'
  end

  def download
    current_user.create_mail_reminder! MailForm::REMINDER_TYPE.first
    file_path = "documents/pdf/#{ current_user.id }/#{ @document.template_name.split(' /<spain/>').first }/#{ params[:filename] }.pdf"
    File.file?(file_path) ? send_file(file_path, :type => "application/pdf", :x_sendfile => true) : redirect_to(pdf_files_path)
  end

  private
  def get_user_document
    @document = current_user.documents.find(params[:document_id])
  end

  def get_user_documents
    @documents = current_user.documents
  end
end

class DocumentAnswersController < ApplicationController
  before_action :get_document, :only => [:edit, :update, :render_questions, :index]

  def edit
    if @document.present?
      @answers = @document.prepare_answers! params[:step].to_i, params[:direction].presence || 'forward'
      #Its correct work without this, need to test?
      @answers = DocumentAnswer.sort @answers, params[:step]
      @review = params[:review]


      if @review.present? && !@answers.blank?
        @url = document_answer_update_path(@document, @answers.first.template_field.template_step.to_i, :review => true)
      elsif !@answers.blank?
        @url = document_answer_update_path(@document, @answers.first.template_field.template_step.to_i)
      end
      redirect_to generate_pdf_path(@document.id) if @answers.blank?
    else
      redirect_to root_path
    end
  end

  def update
    current_step = params[:step].to_i
    params[:step] = params[:step].to_i.next if !@document.update_answers!(answers_params, params[:step].to_i)

    if @document.errors.any?
      redirect_to document_answer_path(@document, params[:step].to_i), :alert => @document.errors.full_messages.first
    elsif params[:review].present?
      redirect_to document_review_path(@document)
    else
      params[:step] = params[:step].to_i.next if current_step == 11 && !@document.check_child_prior_address(current_step)

      redirect_to document_answer_path(@document, params[:step].to_i)
    end
  end

  def render_questions
    answer = DocumentAnswer.find params[:answer_id_first]
    answer.update :answer => '1'
    answer2 = DocumentAnswer.find params[:answer_id_second]
    tmp_value = answer2.answer.to_i

    @document.update_answers!(answers_params, params[:step].to_i)
    @document.create_or_delete_answer params[:value].to_i, answer2, params[:step], tmp_value, answer2.toggler_offset

    @answers = @document.prepare_answers! params[:step], true
    @answers.sort_by!{ |item| [item.toggler_offset, item.sort_index ? 1 : 0, item.sort_index, item.sort_number] }
    @review = params[:review]

    if @review.present? && !@answers.blank?
      @url = document_answer_update_path(@document, @answers.first.template_field.template_step.to_i, :review => true)
    elsif !@answers.blank?
      @url = document_answer_update_path(@document, @answers.first.template_field.template_step.to_i)
    end
  end

  def index
  end

  private
  def get_document
    if user_signed_in?
      @document = current_user.documents.find(params[:document_id])
    else
      @document = Document.where(:id => params[:document_id], :session_uniq_token => cookies[:session_uniq_token], :user_id => nil).first
    end
  end

  def answers_params
    params.require(:document_answer).permit!
  end
end
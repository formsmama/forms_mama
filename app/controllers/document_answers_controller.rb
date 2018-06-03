class DocumentAnswersController < ApplicationController
  before_action :get_document, :only => [:edit, :update, :render_questions, :add_fields_block, :delete_fields_block, :index]
  before_action :get_review, :only => [:edit, :update, :render_questions]

  def edit
    if @document.present?
      @answers = @document.prepare_answers! params[:step].to_i, params[:direction].presence || 'forward'
      @current_step = @answers.first.template_field.template_step.to_i unless @answers.blank?

      redirect_to generate_pdf_path(@document.id) if @answers.blank?
    else
      redirect_to root_path
    end
  end

  def update
    if @document.update_answers! answers_params
      redirect_to document_answer_path(@document, params[:step].to_i, :review => @review), :alert => @document.errors.full_messages.first
    else
      redirect_to @review.present? && params[:btn_review] ?
        document_review_path(@document, :scroll => params[:step]):
        document_answer_path(@document, (params[:step].to_i + (params[:direction] == 'back' ? -1 : 1)), :review => @review)
    end
  end

  def render_questions
    @answers = @document.hidden_answers(params[:answer_id_first], params[:answer_id_second], answers_params, params[:value], params[:step])
    @current_step = params[:step]
  end

  def add_fields_block
    @document.update_answers! answers_params
    @document.add_answers_block! params[:answer_id]
  end

  def delete_fields_block
    @document.update_answers! answers_params
    @document.delete_answers_block! params[:answer_id]
  end

  def index
  end

  private
  def get_review
    @review = @document.review?(params[:step], session) if params[:review]
    @review = params[:review] if @review.nil?
  end

  def get_document
    @document = current_user.documents.find(params[:document_id])
  end

  def answers_params
    params.require(:document_answer).permit!
  end
end
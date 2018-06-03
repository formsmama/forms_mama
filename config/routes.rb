Rails.application.routes.draw do

  devise_for :users


  root 'pdf_files#welcome'

  resources :paypal_payments, :only => [:new, :create]

  resources :templates, :only => [:index] do
    resources :documents, :only => [:create]
  end

  resources :documents, :only => [] do
    get 'step/:step/edit' => 'document_answers#edit', :as => :answer
    post 'step/:step' => 'document_answers#update', :as => :answer_update
    post 'step/:step/render_questions' => 'document_answers#render_questions', :as => :render_questions
    post 'add_fields_block' => 'document_answers#add_fields_block', :as => :add_fields_block
    post 'delete_fields_block' => 'document_answers#delete_fields_block', :as => :delete_fields_block
    get 'review' => 'document_answers#index'
  end

  resources :pdf_files, :only => [:index]
  get 'generate_pdf/document/:document_id' => 'pdf_files#generate', :as => :generate_pdf
  get 'download/document/:document_id/filename/:filename' => 'pdf_files#download', :as => :download_pdf
end

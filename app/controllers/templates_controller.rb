class TemplatesController < ApplicationController

  def index
    @templates = Template.all
    @documents = current_user.documents
  end
end
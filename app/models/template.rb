class Template < ActiveRecord::Base

  has_many :documents
  has_many :steps, :class_name => 'TemplateStep'

  has_many :answers, :class_name => 'DocumentAnswer'

  def to_s
    name
  end

  def to_desc
    description
  end
end

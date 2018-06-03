class TemplateStep < ActiveRecord::Base
  include DivorceComplaintHelper

  has_many :fields, :class_name => 'TemplateField'
  has_many :amount_fields,    :class_name => 'DocumentAnswer', :primary_key => 'amount_field_id', :foreign_key => 'template_field_id'
  has_many :amount_answer_if, :class_name => 'DocumentAnswer', :primary_key => 'amount_field_if', :foreign_key => 'template_field_id'
  has_many :document_answers
  belongs_to :template

  def to_question_title(document=nil)
    [to_s(document)].join('. ')
  end

  def to_s(document=nil)
    # if document.present? && document.to_s == Document::DIVORCE_COMPLAINT
    #   title.gsub!('<spain_self>', document.step_answers(3)[document.step_answers(3).count - 2].try(:answer) == 'Wife' ? 'esposo' : 'esposa')
    #   title.gsub!('<uppercase_spain_self>', document.step_answers(3)[document.step_answers(3).count - 2].try(:answer) == 'Wife' ? 'ESPOSO' : 'ESPOSA')

    #   title.gsub! '<child_count>',           number_of_child(document) == '1' ? 'the child' : 'children'
    #   title.gsub! '<child_count_spain>',     number_of_child(document) == '1' ? 'el menor '  : 'los menores'
    #   title.gsub! '<uppercase_child>',       number_of_child(document) == '1' ? 'CHILD'     : 'CHILDREN'
    #   title.gsub! '<uppercase_child_spain>', number_of_child(document) == '1' ? 'EL MENOR '  : 'LOS MENORES'
    #   title[0] = 'C' if title[0] == 'c'
    #   title[0] = 'T' if title[0] == 't'
    # end
    to_humanize document, title
  end

  def to_i
    step_number.to_i
  end

  def amount_if_answer(document)
    amount_answer_if.this_document(document).first.answer rescue nil
  end

  def to_description(document)
    # Check <insert id= >
    insert = description.match(/<insert id=\d+\/>/)[0] rescue nil
    return to_humanize(document, description) if insert.nil?
    replace_data = TemplateField.find(insert.match(/\d+/)[0]).document_answers.where(:document_id => document.id).first.answer
    # description.sub(insert, replace_data).sub(insert, replace_data)
    to_humanize document, description.sub(insert, replace_data).sub(insert, replace_data)
  end
end

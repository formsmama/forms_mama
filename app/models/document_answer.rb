class DocumentAnswer < ActiveRecord::Base
  include DivorceComplaintHelper

  belongs_to :template_field, -> { includes(:template_step) }
  belongs_to :document
  belongs_to :template_step

  scope :this_document, -> (document){ where(:document_id => document.id) }

  NUMBER_NAME = ['First', 'Second', 'Third', 'Fourth', 'Fifth', 'Sixth', 'Seventh','Eighth','Ninth']
  STATES = [['Alabama', 'AL'],
            ['Alaska', 'AK'],
            ['Arizona', 'AZ'],
            ['Arkansas', 'AR'],
            ['California', 'CA'],
            ['Colorado', 'CO'],
            ['Connecticut', 'CT'],
            ['Delaware', 'DE'],
            ['Florida', 'FL'],
            ['Georgia', 'GA'],
            ['Hawaii', 'HI'],
            ['Idaho', 'ID'],
            ['Illinois', 'IL'],
            ['Indiana', 'IN'],
            ['Iowa', 'IA'],
            ['Kansas', 'KS'],
            ['Kentucky', 'KY'],
            ['Louisiana', 'LA'],
            ['Maine', 'ME'],
            ['Maryland', 'MD'],
            ['Massachusetts', 'MA'],
            ['Michigan', 'MI'],
            ['Minnesota', 'MN'],
            ['Mississippi', 'MS'],
            ['Missouri', 'MO'],
            ['Montana', 'MT'],
            ['Nebraska', 'NE'],
            ['Nevada', 'NV'],
            ['New Hampshire', 'NH'],
            ['New Jersey', 'NJ'],
            ['New Mexico', 'NM'],
            ['New York', 'NY'],
            ['North Carolina', 'NC'],
            ['North Dakota', 'ND'],
            ['Ohio', 'OH'],
            ['Oklahoma', 'OK'],
            ['Oregon', 'OR'],
            ['Pennsylvania', 'PA'],
            ['Rhode Island', 'RI'],
            ['South Carolina', 'SC'],
            ['South Dakota', 'SD'],
            ['Tennessee', 'TN'],
            ['Texas', 'TX'],
            ['Utah', 'UT'],
            ['Vermont', 'VT'],
            ['Virginia', 'VA'],
            ['Washington', 'WA'],
            ['West Virginia', 'WV'],
            ['Wisconsin', 'WI'],
            ['Wyoming', 'WY']]
  PERSON = [['Grandma / Abuela', 'Grandma'],
            ['Grandpa / Abuelo', 'Grandpa'],
            ['Aunt / Tía', 'Aunt'],
            ['Uncle / Tío', 'Uncle'],
            ['Cousin / Primo', 'Cousin'],
            ['Friend / Amigo', 'Friend'],
            ['Godparent / Madrina/Padrino', 'Godparent'],
            ['Stepfather / Padrastro', 'Stepfather'],
            ['Stepmother / Madrastra', 'Stepmother'],
            ['Sister / Hermana', 'Sister'],
            ['Brother / Hermano', 'Brother'],
            ['Other / Otro', 'Other']]

  MONTH_NAMES = ['January / Enero', 'February / Febrero', 'March / Marzo', 'April / Abril', 'May / Mayo', 'June / Junio', 'July / Julio', 'August / Agosto', 'September / Septiembre', 'October / Octubre', 'November / Noviembre', 'December / Diciembre']
  SPAIN_DAYS = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo']

  def to_s
    # if answer.present?
    #   if document.to_s == Document::DIVORCE_COMPLAINT
    #     answer.gsub! '<child_count>',           number_of_child(document) == '1' ? 'child' : 'children'
    #     answer.gsub! '<child_count_spain>',     number_of_child(document) == '1' ? 'el menor '  : 'los menores'
    #     answer.gsub! '<child>',                 number_of_child(document) == '1' ? 'child' : 'children'
    #     sole_count = get_number_of_primary_or_sole_child document
    #     answer.gsub!('<child_percentage_sole>', "#{sole_count} children #{get_percentage_for_children(sole_count)}%")
    #     answer[0] = 'C' if answer[0] == 'c'
    #   elsif document.to_s == Document::FILED_CASE
    #     if answer.match(/<defendant_full_name>/) || answer.match(/<defendant_full_name_spain>/)
    #       defendant_name = get_defendant_full_name(document)
    #       answer.gsub!('<defendant_full_name>', defendant_name)
    #       answer.gsub!('<defendant_full_name_spain>', defendant_name)
    #     end
    #   end
    # end

    ERB::Util.h(to_humanize(document, answer))
  end

  def to_html_array(amount_index=1)
    [(template_field.to_text(document, amount_index).gsub(/<option\/>/, '<br/>').gsub('*', '') rescue ''),
     to_s]
  end

  def step_number
    template_field.template_step.to_i
  end

  def field_type
    template_field.field_type
  end

  def self.sort(_answers, step)
    if step == '50'
      _answers.sort_by!{ |item| [item.sort_index ? 1 : 0, item.sort_index, item.sort_number, item.template_field_id] }
    else
      _answers.sort_by!{ |item| [item.toggler_offset, item.sort_index ? 1 : 0, item.sort_index, item.sort_number, item.template_field_id] }
    end
  end

  def to_spain(amount_index=1)
    return to_s if !template_field.field_type.match(/radio/) || template_field.field_type.match(/text_radio/)
    template_field.to_text(document, amount_index).split('<option/>').each do |a|
      if a.match(Regexp.new answer.split(/\(|\</).first)
        if a.match '<spain/>'
          splited_answer = a.split '<spain/>'
          a = splited_answer[0] + ' <span class="spain">' + splited_answer[1] + '</span>'
        end
        return a.gsub('*', '')
      end
    end
  end
end
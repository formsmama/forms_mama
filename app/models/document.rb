class Document < ActiveRecord::Base
  include DivorceComplaintHelper

  validates :template_name, :presence => true

  has_many :answers, :class_name => 'DocumentAnswer'

  has_one :next_dependent_document, :class_name => 'DependentDocument'
  has_one :next_document, :through => :next_dependent_document, :class_name => 'Document', :foreign_key => 'sub_document_id', :source => :sub_document

  has_one :previous_dependant_document, :class_name => 'DependentDocument', :foreign_key => 'sub_document_id'
  has_one :previous_document, :through => :previous_dependant_document, :class_name => 'Document', :source => :document

  belongs_to :template
  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'

  accepts_nested_attributes_for :answers

  DIVORCE_COMPLAINT = 'Complaint for Divorce /<spain/>Demanda de Divorcio'
  FILED_CASE = 'Filed Case /<spain/>Caso archivado'
  AFTER_SERVICE = "After Service /<spain/>Después de entrega de documentos"

  DIVORCE_PACKET = 'Divorce Complaint /<spain/>Demanda de Divorcio'
  JOINT_PACKET = 'Joint Petition /<spain/>Petición Conjunta'

  TOGGLER_OFFSET = 1000
  BLOCK_DIFFERENCE = 10

  MANDATORY_MESSAGE = 'Check the mandatory fields /<spain/>Por favor, revisa los campos obligatorios'

  #Not for one child
  CHILDREN_QUESTIONS = [15, 17]


  #Controller answers Action edit
  def prepare_answers!(next_step, direction)
    next_step = skip_steps next_step
    _answers = step_answers(next_step) rescue nil
    template_step = TemplateStep.find next_step + template.steps.first.id - 1 rescue nil

    unless template_step.nil?
      # Delete answers
      _looped_amount = looped_amount(next_step, _answers, template_step)

      if (direction == 'forward' && _answers.present? && (template_step.amount_field_id.present? || _answers.select{|a|a.template_field.render_if_id != 0}.present?) && (loop_amount(next_step) != _looped_amount && (template_step.amount_answer_if.nil? || template_step.amount_if_answer(self) == template_step.amount_field_if_option) || _looped_amount != 1 && template_step.amount_if_answer(self) != template_step.amount_field_if_option))

        new_answers = DocumentAnswer.sort(_create_next_step_answers!(next_step), template_step)
        if template_step.fields.where(:field_type => ['loop_button-add', 'loop_button-delete']).exists?
          count = count_of_added_blocks(_answers)
          new_answers.select{ |answer| answer.field_type == 'loop_button-add' }.each_with_index do |a, i|
            count[i] -= 1 if count[i].to_i > 0
            count[i].to_i.times do
              answer_id =  add_answers_block!(answer_id.presence || a.id)
            end
          end
        end
        _answers = DocumentAnswer.sort(_answers.to_a, template_step)
        new_answers = DocumentAnswer.sort(step_answers(next_step).select{ |a| !_answers.map(&:id).include? a.id }, template_step)

        if _looped_amount > loop_amount(next_step)
          new_answers.each_with_index do |a, i|
            a.answer = _answers[i].answer
          end
        else
          _answers.each_with_index do |a, i|
            new_answers[i].answer = a.answer
          end
        end

        new_answers.each{ |na| na.save :validate => false }
        _answers.each(&:destroy)
        _answers = new_answers
      end
    end

    _answers = _create_next_step_answers!(next_step) if _answers.blank?
    DocumentAnswer.sort get_spouses_answers(_answers), next_step
  end

  def _create_next_step_answers!(next_step, toggler_offset=0)
    document_answers = Array.new

    if template.steps.where(:step_number => next_step).exists?
      loop_amount(next_step).times do |i|
        current_step = template.steps.where(:step_number => next_step).first

        current_step.fields.reverse_each do |field|
          if field.raw_question == true && (i == 0 || field.dont_repeat == false)
            params = { :template_field_id => field.id, :template_step_id => field.template_step.id, :toggler_offset => (toggler_offset + i * TOGGLER_OFFSET) }
            params.merge!({ :sort_index => field.sort_index[0], :sort_number => field.sort_index[1, field.sort_index.length].to_i }) if !field.sort_index.nil?

            template_field = TemplateField.find(params[:template_field_id])
            depend_answer = TemplateField.find(template_field.render_if_id).document_answers.where(:document_id => id).first if template_field.render_if_id.present?

            document_answers.push(answers.create(params)) if template_field.render_if_id.nil? || depend_answer.answer.match(template_field.render_if_value)
          end
        end
        break if current_step.amount_field_id.present? && current_step.amount_field_if.present? &&
                 answers.where(:template_field_id => current_step.amount_field_if).exists? &&
                 !answers.where(:template_field_id => current_step.amount_field_if).first.answer.match(current_step.amount_field_if_option)
      end
    end
    document_answers
  end

  #Controller answers Action update
  def update_answers!(answers_params)
    looper = false
    answers_params[:answers].each do |answer|
      _answer = answers.find(answer.first)
      # save answer

      field_answer = answer.last.to_a[1..-1].map{|key,value| value}.reject(&:blank?).join('/') if _answer.template_field.field_type =~ /date/
      _answer.answer = field_answer.to_s.length > 4 ? field_answer : answer.last[:answer]

      _answer.answer = 'No' if _answer.field_type.match(/default_no/) && _answer.answer.blank?
      _answer.answer = "$#{_answer.answer}" if _answer.field_type.match(/\$/) && !_answer.answer.match(/\$/)
      _answer.answer = '000-00-0000' if _answer.answer == '' && _answer.template_field.field_type.match(/social_security/)
      _answer.answer = _answer.answer.upcase if _answer.template_field.field_type.match(/upcase/)
      _answer.answer = _answer.answer.to_s.split(' ').map(&:titleize).join(' ') if _answer.template_field.field_type.match(/capitalize/)
      _answer.save

      looper = add_mandatory_error unless check_mandatory(_answer)
    end
    looper
  end


  # Check mandatory
  def check_mandatory(_answer)
    if _answer.template_field.mandatory.present? && (_answer.answer.nil? || !_answer.answer.match(_answer.template_field.mandatory[:value]))
      step = _answer.template_step
      parent_template = step.fields.where(:toggle_id => _answer.template_field.toggle_id).first
      parent_toggler = answers.where(:template_field_id => parent_template.id, :toggler_offset => _answer.toggler_offset).first
      parent_toggler = answers.where(:template_field_id => parent_template.id).first if parent_toggler.nil?
      toggle_option = _answer.template_field.toggle_option

      return false if (_answer.template_field.toggle_id.nil? || parent_toggler == _answer) && step.fields.where(:sub_toggle_id => _answer.template_field.toggle_id).where.not(:sub_toggle_id => nil).count == 0

      if _answer.template_field.field_type.match(/checkbox/)
        return false if parent_toggler.answer.present? && get_checked_answer_count(_answer) == 0 && parent_toggler.answer.match(toggle_option)
      else
        return false if toggle_option.present? && parent_toggler.answer.present? && parent_toggler.answer.match(toggle_option) ||
                      toggle_option.nil?     && parent_toggler.answer.present? && parent_toggler.answer == '1' ||
                      toggle_option.present? && parent_toggler.answer.present? && parent_toggler.answer.match(toggle_option == 'Yes' ? '1' : 'false')
      end


      if _answer.template_field.mandatory[:template_field].present?

        parent_answer = DocumentAnswer.where(:template_field_id => _answer.template_field.mandatory[:template_field], :document_id => id, :toggler_offset => _answer.toggler_offset).order('id').first

        return false if _answer.answer.nil? && parent_answer.answer == _answer.template_field.mandatory[:toggle_option] ||
                        _answer.answer == '' && parent_answer.answer == _answer.template_field.mandatory[:toggle_option] ||
                        _answer.answer.nil? && parent_answer.template_field.name.split(' /<spain/>').first == _answer.template_field.mandatory[:toggle_option] && parent_answer.answer == '1' ||
                        _answer.answer == '' && parent_answer.template_field.name.split(' /<spain/>').first == _answer.template_field.mandatory[:toggle_option] && parent_answer.answer == '1'
      end
    end

    if !_answer.template_step.fields.where(:field_type =>  ['loop_button-add', 'loop_button-delete']).present? && _answer.sort_number == 2 && _answer.answer.present?
      step = _answer.template_step
      parent_template = step.fields.where(:toggle_id => _answer.template_field.toggle_id).first
      prev_answer = answers.where(:template_field_id => parent_template.id, :toggler_offset => _answer.toggler_offset).first.answer
      if prev_answer == '1' || prev_answer == 'Yes'

        fields_count = step.fields.where(:toggle_id => _answer.template_field.toggle_id).count
        answers_count = step.fields.map{ |f| f.document_answers.where(:document_id => id, :sort_index => _answer.sort_index, :toggler_offset => _answer.toggler_offset) }.flatten.count rescue nil

        unless answers_count - 2 == (fields_count - 2) * _answer.answer.to_i
          _answer.answer = nil
          _answer.save
          return false
        end
      end
    end
    true
  end

  def get_checked_answer_count(_answer)
    template.steps.find(_answer.template_field.template_step.step_number.to_i + template.steps.first.id - 1).fields.where(:toggle_id => _answer.template_field.toggle_id).map{ |item| item.document_answers.where(:answer => '1', :toggler_offset => _answer.toggler_offset) }.flatten.count
  end

  def add_mandatory_error
    errors.add(:base, MANDATORY_MESSAGE) if !errors.any?
    true
  end
  # End of check mandatory


  # Add/delete block of fields
  def add_answers_block!(answer_id)
    #Its Delete button
    last_button = answers.find(answer_id.to_i + 1)
    index = last_button.sort_number
    offset = nil
    last_button.template_step.fields.where(:amount_field_id => TemplateField.find(last_button.template_field_id).amount_field_id).reverse_each do |field|
      offset = last_button.template_step.fields.where(:toggle_id => 2).present? ? last_button.toggler_offset + BLOCK_DIFFERENCE : last_button.toggler_offset
      answers.create(:template_field_id => field.id, :toggler_offset => offset, :sort_index => last_button.sort_index, :sort_number => index += 1, :template_step_id => last_button.template_step_id )
    end
    # This will hide buttons Add and Delete(in _loop_button)
    last_button.update :answer => 'none'
    answers.find(answer_id.to_i).update :answer => 'none'

    answers.where(:template_step_id => last_button.template_step_id, :sort_number => index - 1, :toggler_offset => offset).first.id if index > 1
  end

  def delete_answers_block!(answer_id)
    answer = answers.find answer_id
    offset = answer.template_step.fields.where(:toggle_id => 2).present? ? answer.toggler_offset - BLOCK_DIFFERENCE : answer.toggler_offset
    # This will delete last block
    answers.where(:toggler_offset => answer.toggler_offset, :template_step_id => answer.template_step_id).last(answer.template_step.fields.where(:amount_field_id => TemplateField.find(answer.template_field_id).amount_field_id).count).each{ |ans| ans.delete }
    answers.where(:toggler_offset => offset, :template_step_id => answer.template_step_id).last(2).each{ |ans| ans.update :answer => '' }
  end

  def count_of_added_blocks(answers)
    count = []
    answers.select{ |answer| answer.field_type == 'loop_button-add' }.each{ |answer| count[answer.toggler_offset / 1000] = count[answer.toggler_offset / 1000].to_i + 1 }
    count
  end

  # End of Add/delete block of fields

  # Hidden answers
  def create_hidden_answers!(answer, loop_amount, last_answer, toggler_offset=0)
    step = answer.template_step
    if step.present?
      index = last_answer.sort_number
      loop_amount.times do |i|
        step.fields.where(:amount_field_id => answer.template_field_id).reverse_each do |field|
          answers.create(:template_field_id => field.id, :toggler_offset => toggler_offset, :sort_index => last_answer.sort_index, :sort_number => index += 1, :template_step_id => answer.template_step_id )
        end
      end
    end
  end

  def delete_hidden_answers!(next_step, answer, loop_amount, amount_field_id)
    step = answer.template_step
    if step.present?
      tmp_answers = step_answers(next_step.to_i)
      answers = []
      tmp_answers.each do |item|
        unless item.sort_index.nil?
          answers << item if item.sort_index.include?(answer.sort_index) && item.toggler_offset == answer.toggler_offset
        end
      end
      answers.sort!{ |a, b| b[:sort_number] <=> a[:sort_number] }
      loop_amount *= step.fields.where(:amount_field_id => amount_field_id).count
      loop_amount.times do
        answers.first.delete
        answers.shift
      end
    end
  end

  def get_last_sort_answer(step, sort_char, answer)
    tmp_answers = step_answers(step.to_i)
    answers = []

    tmp_answers.each do |item|
      unless item.sort_index.nil?
        answers << item if item.sort_index.include?(sort_char) && item.toggler_offset == answer.toggler_offset
      end
    end
    answers.sort_by!{ |item| [item.sort_index, item.sort_number] }
    answers.last
  end

  def create_or_delete_answer(value, answer, tmp_value, step)
    toggler_offset = answer.toggler_offset

    if answer.answer.nil?
      create_hidden_answers! answer, value, get_last_sort_answer(step, answer.sort_index, answer), toggler_offset
      answer.update :answer => value
    else
      if tmp_value < value
        create_hidden_answers! answer, value - answer.answer.to_i, get_last_sort_answer(step, answer.sort_index, answer), toggler_offset
      elsif tmp_value > value
        delete_hidden_answers! step, answer, answer.answer.to_i - value, answer.template_field_id
      end
      answer.update :answer => value
    end
  end

  def hidden_answers(answer_id_first, answer_id_second, answers_params, value, step)
    main_answer = DocumentAnswer.find answer_id_first
    main_answer.update :answer => '1'
    count_item_answer = DocumentAnswer.find answer_id_second
    old_value = count_item_answer.answer.to_i

    update_answers!(answers_params)
    create_or_delete_answer value.to_i, count_item_answer, old_value, step

    _answers = prepare_answers! step.to_i, true
    _answers.sort_by!{ |item| [item.toggler_offset, item.sort_index ? 1 : 0, item.sort_index, item.sort_number] }
  end

  def return_value_for_counter(answer)
    return 0 if answer.answer.nil?
    return answer.answer.to_i
  end
  # End of hidden answer



  # DC for Divorce complaint
  DC_HIDE_REVIEW_STEP = (8..29)

  def review?(step_number, session)
    if to_s == DIVORCE_COMPLAINT
      session[:review] = false if DC_HIDE_REVIEW_STEP.first == step_number.to_i
      session[:review] = true if (DC_HIDE_REVIEW_STEP.last  == step_number.to_i || !DC_HIDE_REVIEW_STEP.include?(step_number.to_i)) && session[:review] == false
    end
    session[:review]
  end

  def skip_steps(next_step, direction='forward')
    if template.steps.where(:step_number => next_step).exists? && template.steps.where(:step_number => next_step).first.render_if_field_id.present?
      begin
        while cant_render?(template.steps.where(:step_number => next_step).first)
          next_step = direction == 'forward' ? next_step.next : next_step.pred
        end
      end rescue nil
    end

    next_step
  end

  def cant_render?(step)
    return true if number_of_child(self) == '1' && CHILDREN_QUESTIONS.include?(step.step_number)
    return cant_render_body? step
  end
  def cant_render_body?(step)
    dependant_stages_status = []
    if step.render_if_field_id.present?
      step.render_if_field_id.split('/').each_with_index do |e, i|
        dependant_stages_status << cant_render_body?(TemplateField.find(e.to_i).template_step)
      end
      current_dependent_status = []
      step.render_if_field_id.split('/').each_with_index do |e, i|
        current_dependent_status << (TemplateField.find(e.to_i).document_answers.where(:document_id => id).map(&:answer)).select { |element| element =~ Regexp.new(step.render_if_field_value.split('/')[i]) }.empty?
      end
       !(current_dependent_status.include?(false) && dependant_stages_status.include?(false))
    else
      false
    end
  end

  def step_answers(step)
    step = step.step_number if step.kind_of?(TemplateStep)
    answers.where(:template_step_id => step + template.steps.first.id - 1).order(:id).to_a rescue nil
  end

  def loop_amount(step)
    template.steps.where(:step_number => step).first.amount_fields.this_document(self).first.try(:answer).to_i.presence_in(1..9) || 1 rescue 1
  end

  def looped_amount(step, _answers, template_step=nil)
    if !template_step.nil? && template_step.fields.where(:field_type =>  ['loop_button-add', 'loop_button-delete']).exists?
      _answers.map(&:toggler_offset).map { |toggler| toggler / TOGGLER_OFFSET }.uniq.count
    else
      selected_array = _answers.select{ |item| item.template_field.raw_question == true }
      selected_array.count / template.steps.where(:step_number => step).first.fields.raw_question.count rescue 0
    end
  end

  def to_s
    template.name
  end

  def to_packet
    if template.name == DIVORCE_COMPLAINT
      case step_answers(1).map(&:answer).first.presence
      when DIVORCE_PACKET.split(' /<spain/>').first
        return DIVORCE_PACKET
      when JOINT_PACKET.split(' /<spain/>').first
        return JOINT_PACKET
      end
    end
    to_s
  end

  def self.get_files_name( documents, user )
    _file_names = Array.new
    documents.each do |document|
      _file_names << Dir.glob("documents/pdf/#{ user.id }/#{ document.template_name.split(' /<spain/>').first }/*.pdf").sort_by{ |file| File.stat(file).ino }
    end
    _file_names
  end

  def get_spouses_answers(answers)
    if (get_sex(self) && get_sex(self, 'defendant')) == 'Male'
      result = answers.select{ |item| item.template_field.spouses == 'man' }
      result.count == 0 ? answers.select{ |item| item.template_field.spouses.nil? } : result
    elsif (get_sex(self) && get_sex(self, 'defendant')) == 'Female'
      result = answers.select{ |item| item.template_field.spouses == 'women' }
      result.count == 0 ? answers.select{ |item| item.template_field.spouses.nil? } : result
    else
      answers.select{ |item| item.template_field.spouses.nil? }
    end
  end
end

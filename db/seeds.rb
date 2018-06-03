DocumentAnswer.destroy_all
user = User.where(:email => 'test@gmail.com').first.nil? ? User.create(:email => 'test@gmail.com', :password => '1234567890') : User.where(:email => 'test@gmail.com').first

document = user.create_document Template.where(:name => Document::DIVORCE_COMPLAINT).first.id
_fields = document.template.steps.map{ |item| item.fields.where(:raw_question => true).order(:id) }.flatten
user_info = %w{ 12345 12345678398 test@gmail.com 000-00-0000 }

_fields.each do |field|
  case field.field_type
  when /text_radio/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => 'Same Adress' )
  when /text|label|redirect|loop_button-add|loop_button-delete/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  when /radio/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => ( field.name.match(/Yes/) ? 'Yes' : field.name.split('<option/>').first.split(' /<spain/>').first), :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?) )
  when /string/
    if ( field.mandatory.present? && field.name.split(' /<spain/>').first.match(field.mandatory[:value]) ) || !field.mandatory.present?
      document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => field.name.split(' /<spain/>').first, :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
    else
      result = nil
      user_info.each do |info|
        result = info if info.match(field.mandatory[:value])
      end
      document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => result, :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
    end
  when /states/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => 'CT', :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  when /date_year_only/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => '1/1/2014')
  when /date_after_born|date_without_day/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => '4/1/2012', :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  when /date|date_year_born|date_for_child/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => '4/4/2003', :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  when /checkbox/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => '1', :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  when /sub_amount/
    answer = DocumentAnswer.last
    answer.update( :answer => (answer.template_field.field_type == 'checkbox' ? '0' : 'No') )
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :sort_index => field.sort_index[0], :sort_number => 2 )
  when /amount/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => '1')
  when /select_person/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => 'Grandma', :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  when /time/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => '1:00 AM', :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  when /day_of_week/
    document.answers.create(:template_field_id => field.id, :template_step_id => field.template_step_id, :toggler_offset => 0, :answer => 'Monday', :sort_index => (field.sort_index[0] if field.sort_index.present?), :sort_number => (1 if field.sort_index.present?))
  end
end
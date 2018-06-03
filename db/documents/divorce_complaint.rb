#
# Hints and tricks:
#
# <separate/>  -  for radio only
# postfix '-last' could be added to radio for extra <br/>
# <insert> is marker for :header_ids
# In name e.g.      english <spain/> spain <spain/> example
#
# field_type 'loop_button-add' and 'loop_button-delete' can`t have another class

#NOTICE: name used in link_to_documents tempate AND in lib/pdf_documents/documents/pdf.rb
Template.where( :name => Document::DIVORCE_COMPLAINT).first.try :destroy
template = Template.create :name => Document::DIVORCE_COMPLAINT, :description => 'No description /<spain/>No hay descripción' if !template.present?

step_number = 0

current_step = template.steps.create :step_number => step_number += 1,#1
                                     :title => 'Choice your packet /<spain/>Seleccione su paquete'
toggle_id = 0
toggle_id += 1
packet = current_step.fields.create :name => "#{ Document::JOINT_PACKET }
                                     <option/>#{ Document::DIVORCE_PACKET }", :toggle_id => toggle_id, :field_type => 'radio', :mandatory => { :value => /^[a-zA-Z\s]+$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'text', :name => 'You and your spouse have resolved all issues and want to file as joint petitioners for an uncontested divorce. <br/><spain/>Usted y su cónyuge han resuelto todos los temas asociados con el divorcio y quieren archivar  un divorcio de mutuo acuerdo.', :toggle_id => toggle_id, :toggle_option => 'Joint Petition'
current_step.fields.create :field_type => 'text', :name => 'You and your spouse DO NOT agree to the terms of the divorce OR you have not seen your spouse for a long time. <br/><spain/>Usted y su cónyuge NO ESTÁN de acuerdo en los temas asociados con el  divorcio O no sabe dónde está su cónyuge.', :toggle_id => toggle_id, :toggle_option => 'Divorce Complaint'

current_step = template.steps.create :step_number => step_number += 1,#2
                                     :title => 'In what county are you going to file your case? /<spain/>¿En qué condado va a archivar su caso?'

clark_nye = current_step.fields.create :name => 'Nye<option/>Esmeralda<option/>Mineral', :field_type => 'radio', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1,#3
                                     :title => 'Your Information /<spain/>Su Información'

current_step.fields.create :field_type => 'string upcase', :name => 'Name /<spain/>Nombre: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter name /<spain/>Escriba el nombre' }
current_step.fields.create :field_type => 'string upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:'
current_step.fields.create :field_type => 'string upcase rev_inline', :name => 'Last Name /<spain/>Apellido: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter last name /<spain/>Escriba el apellido' }
current_step.fields.create :field_type => 'date_birthday start_range=-13 end_range=-100', :name => 'Date of Birth /<spain/>Fecha de nacimiento: *', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date of birthday /<spain/>Por favor, ponga la fecha de nacimiento' }
current_step.fields.create :field_type => 'label', :name => 'Gender /<spain/>Género: *'
current_step.fields.create :field_type => 'radio', :name => 'Male /<spain/>Masculino
                                                             <option/>Female /<spain/>Femenino', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'string social_security rev_br', :name => 'Social Security # /<spain/># Seguro Social: <spain/>e.g. XXX-XX-XXXX', :mandatory => { :value => /^([0-9]{3}\D*[0-9]{2}\D*[0-9]{4})?$/, :hint => 'Please enter a valid Social Security Number. /<spain/>Por favor, ponga un número de Seguro Social válido' }
current_step.fields.create :field_type => 'string capitalize', :name => 'Home Address /<spain/>Dirección de casa: *', :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid home address /<spain/>Por favor, ponga una dirección de casa o postal válida' }
current_step.fields.create :field_type => 'string capitalize', :name => 'City /<spain/>Ciudad: *', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }
current_step.fields.create :field_type => 'states rev_inline', :name => 'State /<spain/>Estado: *', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }
current_step.fields.create :field_type => 'string rev_inline rev_br', :name => 'Zip Code /<spain/>Código postal: * ', :mandatory => { :value => /^\w+$/, :hint => 'Please enter a valid zip code /<spain/>Por favor, ponga un código postal válido' }
current_step.fields.create :field_type => 'text_radio capitalize', :name => 'Mailing Address /<spain/>Dirección de correo o postal: *', :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid mailing address /<spain/>Por favor, ponga una dirección de casa o postal válida' }
current_step.fields.create :field_type => 'string capitalize', :name => 'City /<spain/>Ciudad: *', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }
current_step.fields.create :field_type => 'states rev_inline', :name => 'State /<spain/>Estado: *', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }
current_step.fields.create :field_type => 'string rev_inline rev_br', :name => 'Zip Code /<spain/>Código postal: * ', :mandatory => { :value => /^\w+$/, :hint => 'Please enter a valid zip code /<spain/>Por favor, ponga un código postal válido' }
current_step.fields.create :field_type => 'string rev_br', :name => 'Phone number /<spain/>Número de teléfono: * <spain/>e.g. (xxx) xxx-xxxx', :mandatory => { :value => /^[A-Za-z0-9\- ()]{2,20}$/, :hint => 'Please enter a valid Phone Number /<spain/>Por favor, ponga un número de teléfono válido' }
current_step.fields.create :field_type => 'string rev_br', :name => 'Email /<spain/>Correo Electrónico: *', :mandatory => { :value => /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})+$/, :hint => 'Please enter a valid email /<spain/>Por favor, ponga un correo electrónico válido' }
current_step.fields.create :field_type => 'text', :name => 'Since you are the person starting the <packet>, you will be referred as the <plaintiff_role>.
                                                            <br/><spain/>Ya que usted es la persona que inicia la acción de <packet_spain>, usted será referido como el <plaintiff_role_spain>'

current_step = template.steps.create :step_number => step_number += 1,#4
                                     :title => 'Your Spouse\'s Information /<spain/>Información de su Cónyuge',
                                     :description => 'This person will be referred as the <defendant_role><br/><spain/>Esta persona será referida como el demandado <defendant_role_spain>'

current_step.fields.create :field_type => 'string upcase', :name => 'Name /<spain/>Nombre: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter name /<spain/>Escriba el nombre' }
current_step.fields.create :field_type => 'string upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:'
current_step.fields.create :field_type => 'string upcase rev_inline', :name => 'Last Name /<spain/>Apellido: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter last name /<spain/>Escriba el apellido' }
current_step.fields.create :field_type => 'date_birthday start_range=-13 end_range=-100', :name => 'Date of Birth /<spain/>Fecha de nacimiento: *', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date of birthday /<spain/>Por favor, ponga la fecha de nacimiento' }
current_step.fields.create :field_type => 'label', :name => 'Gender /<spain/>Género: *'
current_step.fields.create :field_type => 'radio', :name => 'Male /<spain/>Masculino
                                                             <option/>Female /<spain/>Femenino', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'string social_security rev_br', :name => 'Social Security # /<spain/># Seguro Social: <spain/>e.g. XXX-XX-XXXX', :mandatory => { :value => /^([0-9]{3}\D*[0-9]{2}\D*[0-9]{4})?$/, :hint => 'Please enter a valid Social Security Number. /<spain/>Por favor, ponga un número de Seguro Social válido' }
current_step.fields.create :field_type => 'string capitalize', :name => 'Mailing Address or last Known address /<spain/>Dirección postal o última dirección:', :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid mailing address /<spain/>Por favor, ponga una dirección de casa o postal válida' }

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'In the United States /<spain/>En los Estados Unidos
                                                            <option/> Unknown /<spain/> No Se
                                                             <option/>Outside the United States /<spain/>Fuera de los Estados Unidos', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'string capitalize', :name => 'City /<spain/>Ciudad: ',  :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }
current_step.fields.create :field_type => 'states rev_inline', :name => 'State /<spain/>Estado:', :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }

current_step.fields.create :field_type => 'string capitalize', :name => 'City/Town/Province: /<spain/>Ciudad/Pueblo/Provincia:', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a City/Town/Province /<spain/>Por favor, proporciona una Ciudad/Pueblo/Provincia' }
current_step.fields.create :field_type => 'string capitalize rev_inline', :name => 'Country /<spain/>País:', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage country /<spain/>Por favor, proporciona el país' }
current_step.fields.create :field_type => 'string rev_inline rev_br', :name => 'Zip Code /<spain/>Código postal:', :mandatory => { :value => /^\w+$/, :hint => 'Please enter a valid zip code /<spain/>Por favor, ponga un código postal válido' }
current_step.fields.create :field_type => 'string rev_br', :name => 'Email /<spain/>Correo Electrónico:', :mandatory => { :value => /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})?+$/, :hint => 'Please enter a valid email /<spain/>Por favor, ponga un correo electrónico válido' }
current_step.fields.create :name => 'Phone number /<spain/>Número de teléfono: <spain/>e.g. (xxx) xxx-xxxx', :mandatory => { :value => /^([A-Za-z0-9\- ()]{2,20})?$/, :hint => 'Please enter a valid Phone Number /<spain/>Por favor, ponga un número de teléfono válido' }


toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1,#5
                                     :title => 'Marriage Information /<spain/>Información de Matrimonio',
                                     :description => 'Where were you married? /<spain/>¿Dónde se casaron?'

current_step.fields.create :name => 'In the United States /<spain/>En los Estados Unidos
                                     <option/>Outside the United States /<spain/>Fuera de los Estados Unidos', :toggle_id => toggle_id, :field_type => 'radio', :mandatory => { :value => /^[a-zA-Z\s]+$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :name => 'City /<spain/>Ciudad: *',  :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage city /<spain/>Por favor, proporciona una ciudad donde se casaron' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'states', :name => 'State /<spain/>Estado: *', :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage state /<spain/>Por favor, proporciona un estado donde se casaron' }

current_step.fields.create :name => 'City/Town/Province: /<spain/>Ciudad/Pueblo/Provincia: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage City/Town/Province /<spain/>Por favor, proporciona una Ciudad/Pueblo/Provincia donde se casaron' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Country /<spain/>País: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage country /<spain/>Por favor, proporciona el país donde se casaron' }, :field_type => 'string-capitalize'

current_step.fields.create :name => 'Marriage Date /<spain/>Fecha de matrimonio:', :field_type => 'date', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Provide a marriage date /<spain/>Por favor proporciona una fecha de matrimonio' }
current_step.fields.create :name => 'Don’t remember the date? Got married in Clark County? <a href="https://recorder.co.clark.nv.us/RecorderEcommerce/">Click here</a><br/><spain/>¿No recuerda la fecha? ¿Se casó en el Condado de Clark? <a href="https://recorder.co.clark.nv.us/RecorderEcommerce/">Haz clic</a>', :field_type => 'text'


current_step = template.steps.create :step_number => step_number += 1,#6
                                     :title => 'Nevada Residency /<spain/>Residente de Nevada',
                                     :description => 'The party filing for divorce must be a Nevada resident for at least six weeks before the filing date.<br/>
                                                      A resident witness will need to sign an affidavit stating your residency in Nevada (relatives are allowed).<br/>
                                                      <spain/>Si usted es la persona que está presentando el divorcio, debe ser residente de Nevada por lo menos 6 semanas antes de archivar la demanda de divorcio.<br/>
                                                      El testigo de residencia deberá firmar una declaración jurada indicando que usted es residente de Nevada (se permiten familiares).'

current_step.fields.create :field_type => 'checkbox', :name => 'I have lived in Nevada for over 6 weeks. /<spain/>Yo, he vivido en Nevada por más de 6 semanas.', :mandatory => { :value => /^1$/, :hint => 'You need to be a Nevada resident before you can file for a divorce /<spain/>Usted tiene que ser un residente de Nevada antes de poder solicitar el divorcio' }

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1,#7
                                     :title => 'Pregnancy /<spain/>Embarazada'

current_step.fields.create :field_type => 'text', :name => 'To my knowledge wife /<spain/>A mi conocimiento la esposa'
current_step.fields.create :field_type => 'radio', :name => 'IS NOT currently pregnant /<spain/>NO ESTÁ embarazada en este momento.
                                                             <option/>IS currently pregnant /<spain/>ESTÁ embarazada en este momento.', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'date_year_born end_range=1 review_show', :name => 'When is unborn child due? /<spain/>¿Qué fecha va nacer él bebe?', :toggle_id => toggle_id, :toggle_option => 'IS currently pregnant', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date/<spain/>Por favor, introduzca una fecha' }
current_step.fields.create :field_type => 'text review_show', :name => 'Is the husband the father of the unborn child? /<spain/>¿El esposo es el padre del niño por nacer?', :toggle_id => toggle_id, :toggle_option => 'IS currently pregnant'
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :toggle_option => 'IS currently pregnant', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sub_toggle_id => toggle_id + 1

current_step.fields.create :field_type => 'text', :name => 'Is one or both of the spouses pregnant? /<spain/>¿Esta uno o ambos cónyuges embarazada?', :spouses => 'women'
current_step.fields.create :field_type => 'checkbox', :name => 'IS NOT currently pregnant /<spain/>NO ESTÁ embarazada en este momento.', :spouses => 'women'
current_step.fields.create :field_type => 'checkbox', :name => '<plaintiff_full_name> IS currently pregnant /<spain/><plaintiff_full_name> ESTÁ embarazada en este momento.', :toggle_id => toggle_id, :spouses => 'women'
current_step.fields.create :field_type => 'date_year_born end_range=1 review_show', :name => 'When is unborn child due? /<spain/>¿Qué fecha va nacer él bebe?', :toggle_id => toggle_id, :toggle_option => 'IS currently pregnant', :spouses => 'women', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date/<spain/>Por favor, introduzca una fecha' }

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => '<defendant_full_name> IS currently pregnant /<spain/><defendant_full_name> ESTÁ embarazada en este momento.', :toggle_id => toggle_id, :spouses => 'women', :mandatory => { :value => /1/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'date_year_born end_range=1 review_show', :name => 'When is unborn child due? /<spain/>¿Qué fecha va nacer él bebe?', :toggle_id => toggle_id, :toggle_option => 'IS currently pregnant', :spouses => 'women', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date/<spain/>Por favor, introduzca una fecha' }



current_step = template.steps.create :step_number => step_number += 1,#8
                                     :title => 'Children /<spain/>Menores',
                                     :description => 'Are there children born or legally adopted of this marriage UNDER the age of 18?<br/><spain/>¿Hay menores de 18 años nacidos o adoptados legalmente de este matrimonio?'

toggle_id = 0
toggle_id += 1
children_field = current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'text', :name => 'How many minor children were born or legally adopted during this marriage?
                                                            <br/><spain/>¿Cuántos  menores nacieron o fueron adoptados legalmente durante este matrimonio?', :toggle_id => toggle_id, :toggle_option => 'Yes'
children_amount_field = current_step.fields.create :field_type => 'amount', :mandatory => { :value => /^[1-9]{1}$/, :hint => 'Please enter correct value /<spain/>Por favor, introduzca el valor correcto' }, :toggle_id => toggle_id, :toggle_option => 'Yes'

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id,#9
                                     :title => '<child_count> Information /<spain/>Información <child_count_spain>'

child_name = current_step.fields.create :field_type => 'string upcase', :name => 'Name /<spain/>Nombre: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter name /<spain/>Escriba el nombre' }
current_step.fields.create :field_type => 'string upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:'

child_last_name = current_step.fields.create :field_type => 'string upcase rev_inline', :name => 'Last Name /<spain/>Apellido: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter last name /<spain/>Escriba el apellido' }
child_birth = current_step.fields.create :field_type => 'date_for_child end_range=-19', :name => 'Date of Birth /<spain/>Fecha de nacimiento: *', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date of birthday /<spain/>Por favor, ponga la fecha de nacimiento' }

current_step.fields.create :field_type => 'text review_show', :name => 'Place of Birth /<spain/>Lugar de nacimiento:'
current_step.fields.create :field_type => 'radio', :name => 'In the United States /<spain/>En los Estados Unidos
                                                             <option/>Outside the United States /<spain/>Fuera de los Estados Unidos', :toggle_id => toggle_id, :mandatory => { :value => /^[a-zA-Z\s]+$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'string capitalize', :name => 'City /<spain/>Ciudad: *',  :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }
current_step.fields.create :field_type => 'states rev_inline', :name => 'State /<spain/>Estado: *', :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }

current_step.fields.create :field_type => 'string capitalize', :name => 'City/Town/Province: <spain/>Ciudad/Pueblo/Provincia: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a City/Town/Province /<spain/>Por favor, proporciona una Ciudad/Pueblo/Provincia' }
current_step.fields.create :field_type => 'string capitalize rev_inline', :name => 'Country /<spain/>País: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a country /<spain/>Por favor, proporciona el país' }

current_step.fields.create :field_type => 'string social_security', :name => 'Social Security # /<spain/># Seguro Social: <spain/>e.g. XXX-XX-XXXX', :mandatory => { :value => /^([0-9]{3}\D*[0-9]{2}\D*[0-9]{4})?$/, :hint => 'Please enter a valid Social Security Number. /<spain/>Por favor, ponga un número de Seguro Social válido' }
current_step.fields.create :field_type => 'radio rev_br', :name => 'Son /<spain/>Hijo <option/>Daughter /<spain/>Hija', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id.to_s, :render_if_field_value => 'Yes', #10
                                     :title => '<child_count>’s Residency /<spain/>Residencia <child_count_spain>'

current_step.fields.create :field_type => 'text', :name => '<child_count> must have resided in Nevada for a minimum of 6 months before the Nevada District Court will take jurisdiction over them.<br/>
                                                            <spain/><residency_child> haber vivido en Nevada por un mínimo de 6 meses antes  que la corte de Nevada tenga el poder judicial sobre <el_ellos>.'
current_step.fields.create :field_type => 'text', :name => 'Have <child_count> lived in Nevada for over 6 months? /<spain/>¿<residency_child_second> en Nevada por más de 6 meses?'

toggle_id = 0
toggle_id += 1
continue_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'text', :name => 'Nevada Court does not have the legal right to set custody at this time, BUT you can still get a divorce without custody. However, you will need to address the children’s health insurance and child support issue.<br/><spain/>
                                                            No. La corte de Nevada no tiene el poder para establecer custodia en este momento, PERO usted todavía puede divorciarse sin custodia.', :toggle_id => toggle_id, :toggle_option => 'No'
current_step.fields.create :field_type => 'text', :name => 'Do you still want to continue? /<spain/>¿Quiere continuar?', :toggle_id => toggle_id, :toggle_option => 'No'
current_step.fields.create :field_type => 'redirect', :name => 'No<link=/templates>
                                                                <option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :toggle_option => 'No', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sub_toggle_id => toggle_id + 1



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, #11
                                     :title => '<child_count>’s Address /<spain/>Dirección <child_count_spain>', :description => 'The law requires that you provide the address where <child_count> have lived for the last 5 years.
                                                              If <child_count> is younger than 5 year old, where <child_count> has lived since birth.
                                                            If you don’t remember all the address do your best by using the internet since your document might be returned by the Judge if a lot of the information is missing.<br/><spain/>
                                                            La ley requiere que usted proporcione la dirección donde <child_count_spain> han vivido durante los últimos 5 años. Si <child_count_spain> tiene menos de 5 años de edad, escriba las direcciones donde ha vivido desde que nació.
                                                            Si no recuerda todas las direcciones trate de usar el internet ya que pueda ser que el juez le devuelva el documento si falta mucha de la información.'

top_field = current_step.fields.create :field_type => 'text review_show',
                                           :name => '<insert> <birth_date>',
                                           :header_ids => "#{ child_name.id }/#{ child_last_name.id }/#{ child_birth.id }",
                                           :sort_index => 'a1'

current_step.fields.create :field_type => 'text',
                           :name => 'Address information /<spain/>Información de dirección',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio',
                           :name => 'Same as me /<spain/>La misma que yo<option/>In the United States /<spain/>En los Estados Unidos<option/>Outside the United States /<spain/>Fuera de los Estados Unidos',
                           :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' },
                           :toggle_id => toggle_id,
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'


current_step.fields.create :field_type => 'date_after_born rev_inline rev_br',
                           :name => 'Child moved to my address /<spain/>El menor se mudó a mi dirección',
                           :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please select date /<spain/>Por favor seleccione la fecha' },
                           :toggle_id => toggle_id, :toggle_option => 'Same as me',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1',
                           :header_ids => "#{ child_birth.id }"


current_step.fields.create :field_type => 'string capitalize',
                           :name => 'Address /<spain/>Dirección: *',
                           :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid home address /<spain/>Por favor, ponga una dirección de casa o postal válida' },
                           :toggle_id => toggle_id, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'string capitalize rev_inline',
                           :name => 'City /<spain/>Ciudad: *',
                           :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' },
                           :toggle_id => toggle_id, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'states rev_inline',
                           :name => 'State /<spain/>Estado: *',
                           :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' },
                           :toggle_id => toggle_id, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'string rev_inline',
                           :name => 'Zip Code /<spain/>Código postal: * ',
                           :mandatory => { :value => /^\w+$/, :hint => 'Please enter a valid zip code /<spain/>Por favor, ponga un código postal válido' },
                           :toggle_id => toggle_id, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'date_after_born rev_inline',
                           :name => 'Child moved to this address /<spain/>El menor se mudó a esta dirección',
                           :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please select date /<spain/>Por favor seleccione la fecha' },
                           :toggle_id => toggle_id, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1',
                           :header_ids => "#{ child_birth.id }"

current_step.fields.create :field_type => 'checkbox review_yes_only',
                           :name => '<plaintiff_full_name>',
                           :toggle_id => toggle_id, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'
current_step.fields.create :field_type => 'checkbox review_yes_only',
                           :name => '<defendant_full_name>',
                           :toggle_id => toggle_id, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'
field_for_mandatory_first = current_step.fields.create :field_type => 'checkbox review_yes_only',
                                                       :name => 'Other /<spain/>Otra',
                                                       :mandatory => { :value => /1/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' },
                                                       :toggle_id => toggle_id, :toggle_option => 'In the United States',
                                                       :sub_toggle_id => toggle_id + 1,
                                                       :amount_field_id => top_field.id,
                                                       :sort_index => 'a1'

current_step.fields.create :field_type => 'string capitalize',
                           :name => 'Address /<spain/>Dirección: *',
                           :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid home address /<spain/>Por favor, ponga una dirección de casa o postal válida' },
                           :toggle_id => toggle_id, :toggle_option => 'Outside the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'string-capitalize rev_inline',
                           :name => 'City-Town-Province /<spain/>Ciudad-Pueblo-Provincia: *',
                           :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' },
                           :toggle_id => toggle_id, :toggle_option => 'Outside the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'string-capitalize rev_inline',
                           :name => 'Country /<spain/>País: * ',
                           :mandatory => { :value => /^\w+$/, :hint => 'Provide a country /<spain/>Por favor, proporcionar un país' },
                           :toggle_id => toggle_id, :toggle_option => 'Outside the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'date_after_born rev_inline',
                           :name => 'Child moved to this address /<spain/>El menor se mudó a esta dirección',
                           :toggle_id => toggle_id, :toggle_option => 'Outside the United States',
                           :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please select date /<spain/>Por favor seleccione la fecha' },
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1',
                           :header_ids => "#{ child_birth.id }"

current_step.fields.create :field_type => 'checkbox review_yes_only',
                           :name => '<plaintiff_full_name>',
                           :toggle_id => toggle_id, :toggle_option => 'Outside the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'
current_step.fields.create :field_type => 'checkbox review_yes_only',
                           :name => '<defendant_full_name>',
                           :toggle_id => toggle_id, :toggle_option => 'Outside the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

field_for_mandatory_second = current_step.fields.create :field_type => 'checkbox review_yes_only',
                                                        :name => 'Other /<spain/>Otra',
                                                        :mandatory => { :value => /1/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' },
                                                        :toggle_id => toggle_id, :toggle_option => 'Outside the United States',
                                                        :sub_toggle_id => toggle_id + 2,
                                                        :amount_field_id => top_field.id,
                                                        :sort_index => 'a1'



current_step.fields.create :field_type => 'string capitalize',
                           :name => 'Name of person /<spain/>Nombre de la persona: *',
                           :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid Name /<spain/>Por favor ingrese un nombre válido',
                                           :template_field => field_for_mandatory_first.id, :toggle_option => 'Other' },
                           :toggle_id => toggle_id + 1, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'select_person',
                           :name => 'Relationship to child /<spain/>Parentesco con el menor: *',
                           :mandatory => { :value => /\w+/, :hint => 'Select person /<spain/>Por favor, Seleccione persona',
                                           :template_field => field_for_mandatory_first.id, :toggle_option => 'Other' },
                           :toggle_id => toggle_id + 1, :toggle_option => 'In the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'string capitalize',
                           :name => 'Name of person /<spain/>Nombre de la persona: *',
                           :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid Name /<spain/>Por favor ingrese un nombre válido',
                                           :template_field => field_for_mandatory_second.id, :toggle_option => 'Other' },
                           :toggle_id => toggle_id + 2, :toggle_option => 'Outside the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'

current_step.fields.create :field_type => 'select_person',
                           :name => 'Relationship to child /<spain/>Parentesco con el menor: *',
                           :mandatory => { :value => /\w+/, :hint => 'Select person /<spain/>Por favor, Seleccione persona',
                                           :template_field => field_for_mandatory_second.id, :toggle_option => 'Other' },
                           :toggle_id => toggle_id + 2, :toggle_option => 'Outside the United States',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'



current_step.fields.create :field_type => 'loop_button-add',
                           :name => 'Add other address /<spain/> Anadir otra dirección',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'
current_step.fields.create :field_type => 'loop_button-delete',
                           :name => 'Delete last address /<spain/> Eliminar la última dirección',
                           :amount_field_id => top_field.id,
                           :sort_index => 'a1'





current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, #12
                                     :title => '<child>’s Question 1 /<spain/><child_count_spain> pregunta 1'
current_step.fields.create :field_type => 'text review_show', :name => 'Have YOU PARTICIPATED as a party, witness or any other capacity in any other litigation or custody proceeding in this or any other state concerning custody of <insert>?<br/><spain/>¿HA PARTICIPADO USTED como demandado, demandante,  testigo o de cualquier otro modo en cualquier otro caso de custodia con <insert> en este u otro estado ?', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
toggle_id = 0
toggle_id += 1
participated = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sort_index => 'a1'
current_step.fields.create :field_type => 'text', :name => 'Your role in the case: * /<spain/>Que fue su participación en el caso: *', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'radio', :name => 'Party /<spain/>Demandado  o demandante<option/>Witness /<spain/>Testigo<option/>Other /<spain/>Otra', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :toggle_id => toggle_id, :sub_toggle_id => toggle_id + 1, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :name => '', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'string-capitalize', :name => 'Name of court: * /<spain/>Nombre de la corte: *', :mandatory => { :value => /\w+/, :hint => 'Provide a name of court /<spain/>Por favor, proporcionar un nombre de la corte' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'states', :name => 'State /<spain/>Estado: *', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :name => 'Case number: /<spain/>Número de caso: ', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :name => 'Date of court order or Judgment: * /<spain/>Fecha de la orden judicial o sentencia: *', :field_type => 'date', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date /<spain/>Por favor, introduzca una fecha' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id

current_step.fields.create :field_type => 'loop_button-add', :name => 'Add /<spain/> Añadir', :amount_field_id => participated.id, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1'
current_step.fields.create :field_type => 'loop_button-delete', :name => 'Delete /<spain/> Eliminar', :amount_field_id => participated.id, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1'

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, #13
                                     :title => '<child>’s Question 2 /<spain/><child_count_spain> pregunta 2'
current_step.fields.create :field_type => 'text review_show', :name => 'IS THERE ANY proceeding at this time including cases of domestic violence, protective orders, termination of parental rights or adoption in this state or another regarding <insert>?<br/><spain/>¿HAY ALGÚN procedimiento en este momento, incluyendo caso de violencia doméstica, órdenes de protección, patria potestad o adopción en este estado o en otro con respecto a <insert>?', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
toggle_id = 0
toggle_id += 1
participated = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sort_index => 'a1'
current_step.fields.create :field_type => 'text', :name => 'Your role in the case: * /<spain/>Que fue su participación en el caso: *', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'radio', :name => 'Party /<spain/>Demandado  o demandante<option/>Witness /<spain/>Testigo<option/>Other /<spain/>Otra', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :toggle_id => toggle_id, :sub_toggle_id => toggle_id + 1, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :name => '', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'string-capitalize', :name => 'Name of court: * /<spain/>Nombre de la corte: *', :mandatory => { :value => /\w+/, :hint => 'Provide a name of court /<spain/>Por favor, proporcionar un nombre de la corte' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'states', :name => 'State /<spain/>Estado: *', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :name => 'Case number: /<spain/>Número de caso: ', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :name => 'Date of court order or Judgment: * /<spain/>Fecha de la orden judicial o sentencia: *', :field_type => 'date', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date /<spain/>Por favor, introduzca una fecha' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id

current_step.fields.create :field_type => 'loop_button-add', :name => 'Add /<spain/> Añadir', :amount_field_id => participated.id, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1'
current_step.fields.create :field_type => 'loop_button-delete', :name => 'Delete /<spain/> Eliminar', :amount_field_id => participated.id, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1'

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, #14
                                     :title => '<child>’s Question 3 /<spain/><child_count_spain> pregunta 3'

current_step.fields.create :field_type => 'text review_show', :name => 'DO YOU KNOW of anyone, besides you and the other parent of <insert>, that has physical custody or came of custody or visitation rights over <insert>?<br/><spain/>¿CONOCE de alguien, que no sea usted y el otro padre de <insert>, que tiene la custodia física o derecho de custodia o visitas de <insert>?', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
toggle_id = 0
toggle_id += 1
participated = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sort_index => 'a1'
current_step.fields.create :field_type => 'string-capitalize review_show', :name => 'Name of person: * /<spain/>Nombre de la persona: *', :mandatory => { :value => /\w+/, :hint => 'Please enter a valid Name /<spain/>Por favor ingrese un nombre válido' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'string-capitalize review_show', :name => 'Address: * /<spain/>Dirección: *', :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid home address /<spain/>Por favor, ponga una dirección de casa o postal válida' }, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1', :amount_field_id => participated.id
current_step.fields.create :field_type => 'radio-last rev_br', :name => 'Person has PHYSICAL custody <insert> /<spain/>Persona  tiene la custodia FÍSICA <insert><option/>Person claims CUSTODY rights <insert> /<spain/>Persona  reclama los derechos de CUSTODIA <insert><option/>Person claim VISITATION rights <insert> /<spain/>Persona reclamar derechos de VISITAS <insert>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :toggle_option => 'Yes', :header_ids => "#{ child_name.id }/#{ child_last_name.id }", :sub_toggle_id => toggle_id + 1, :sort_index => 'a1', :amount_field_id => participated.id

current_step.fields.create :field_type => 'loop_button-add', :name => 'Add /<spain/> Añadir', :amount_field_id => participated.id, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1'
current_step.fields.create :field_type => 'loop_button-delete', :name => 'Delete /<spain/> Eliminar', :amount_field_id => participated.id, :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a1'

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes',#15
                                     :title => 'Same Legal Custody /<spain/>Misma Custodia Legal',
                                     :description => 'Do you want all the children to have the same legal custody?
                                                      <br/><spain/>¿Quiere que todos los menores tenga la misma custodia legal?'
toggle_id = 0
toggle_id += 1
same_schedule_legal_custody = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, :amount_field_if => same_schedule_legal_custody.id, :amount_field_if_option => 'No',#16
                                     :title => 'Legal Custody /<spain/>Custodia Legal',
                                     :description => 'Who will have legal custody of <child_count>? /<spain/>¿Quién tendrá la custodia legal <child_count_spain>?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'text review_show', :name => 'Legal custody of <insert>.<spain/>Custodia legal de <insert>.', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
current_step.fields.create :field_type => 'radio', :name => 'BOTH Parents /<spain/>AMBOS padres
                                                             <option/>Only <plaintiff_full_name> /<spain/>Solo <plaintiff_full_name>
                                                             <option/>Only <defendant_full_name> /<spain/>Solo <defendant_full_name>', :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'text review_show', :name => 'Do you need <defendant_full_name> to sign legal documents such as a passport application?'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id, :render_if_field_value => 'Yes',#17
                                     :title => 'Same Physical Custody /<spain/>Misma Custodia Física',
                                     :description => 'Do you want all the children to have the same physical custody?
                                                      <br/><spain/>¿Quiere que todos los menores tengan la misma custodia física?'
toggle_id = 0
toggle_id += 1
same_schedule_physical_custody = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, :amount_field_if => same_schedule_physical_custody.id, :amount_field_if_option => 'No',#18
                                     :title => 'Physical Custody /<spain/>Custodia Física',
                                     :description => 'Select the type of custody you would like to have:
                                                      <br/><spain/>Seleccione el tipo de custodia que usted desea:'

current_step.fields.create :field_type => 'text review_show', :name => 'Physical custody of <insert>.<spain/>Custodia física de <insert>.', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
current_step.fields.create :field_type => 'label', :name => 'PRIMARY PHYSICAL CUSTODY /<spain/>CUSTODIA FISICA PRIMARIA'
current_step.fields.create :field_type => 'label', :name => 'PRIMARY PHYSICAL CUSTODY: when <child_lives> with one parent for most of the time (more than 60%) and has limited visitation with the other parent. <br/><spain/>CUSTODIA FISICA PRIMARIA : cuando <child_lives_spain> con un padre/madre más del 60% y el otro padre/madre tiene visitas.<spain/>'

toggle_id = 0
toggle_id += 1
custody_field = current_step.fields.create :field_type => 'radio-sub', :name => 'With <plaintiff_full_name> and visits with <defendant_full_name> /<spain/>Con <plaintiff_full_name> y visitas con <defendant_full_name>.
                                                                 <option/>With <defendant_full_name> and visit with <plaintiff_full_name> /<spain/>Con <defendant_full_name> y visitas con <plaintiff_full_name>.<spain/><place_for_insert>
                                                                 <separate/>JOINT PHYSICAL CUSTODY: when <child_lives> with both parent 50/50 or 60/40 of the time.<spain/><br/>Con papá y visitas con mamá: Custodia FISICA COMPARTIDA: cuando <child_lives_spain> con ambos padres 50/50 o 60/40 del tiempo.
                                                                 <option/>Both Parents /<spain/>Ambos padres.<spain/><place_for_insert>
                                                                 <separate/>SOLE PHYSICAL CUSTODY: when <child_lives> with one parent.<spain/><br/>Ambos padres: CUSTODIA FÍSICA ÚNICA: cuando <child_lives_spain> solamente con uno de los padres.
                                                                 <option/>Only with the <plaintiff_full_name> /<spain/>Solo con mamá
                                                                 <option/>Only with the <defendant_full_name> /<spain/>Solo con papá', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Visitation with <defendant_full_name> will be /<spain/>Las visitas con el <defendant_full_name> serán:', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => '<defendant_full_name> days off /<spain/><defendant_full_name> los días de descanso', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => '1 Weekend a month /<spain/>1 fin de semana al mes', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => 'Every Other Weekend /<spain/>Fin de semana por medio', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => 'Every weekend /<spain/>Todos los fin de semana', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
field_for_mandatory_monday = current_step.fields.create :field_type => 'checkbox', :name => 'Monday /<spain/>Lunes', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :sub_toggle_id => toggle_id + 1, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 1, :name => 'From /<spain/>Desde', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 1, :name => 'To /<spain/>Hasta', :toggle_option => 'With <plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_monday.id, :toggle_option => 'Monday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 1, :name => 'and /<spain/>y', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'

field_for_mandatory_tuesday = current_step.fields.create :field_type => 'checkbox', :name => 'Tuesday /<spain/>Martes', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :sub_toggle_id => toggle_id + 2, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 2, :name => 'From /<spain/>Desde', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 2, :name => 'To /<spain/>Hasta', :toggle_option => 'With <plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_tuesday.id, :toggle_option => 'Tuesday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 2, :name => 'and /<spain/>y', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'

field_for_mandatory_wednesday = current_step.fields.create :field_type => 'checkbox', :name => 'Wednesday /<spain/>Miércoles', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :sub_toggle_id => toggle_id + 3, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 3, :name => 'From /<spain/>Desde', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 3, :name => 'To /<spain/>Hasta', :toggle_option => 'With <plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_wednesday.id, :toggle_option => 'Wednesday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 3, :name => 'and /<spain/>y', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'

field_for_mandatory_thursday = current_step.fields.create :field_type => 'checkbox', :name => 'Thursday /<spain/>Jueves', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :sub_toggle_id => toggle_id + 4, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 4, :name => 'From /<spain/>Desde', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 4, :name => 'To /<spain/>Hasta', :toggle_option => 'With <plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_thursday.id, :toggle_option => 'Thursday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 4, :name => 'and /<spain/>y', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'

field_for_mandatory_friday = current_step.fields.create :field_type => 'checkbox', :name => 'Friday /<spain/>Viernes', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :sub_toggle_id => toggle_id + 5, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 5, :name => 'From /<spain/>Desde', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 5, :name => 'To /<spain/>Hasta', :toggle_option => 'With <plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_friday.id, :toggle_option => 'Friday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 5, :name => 'and /<spain/>y', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'

field_for_mandatory_saturday = current_step.fields.create :field_type => 'checkbox', :name => 'Saturday /<spain/>Sábado', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :sub_toggle_id => toggle_id + 6, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 6, :name => 'From /<spain/>Desde', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 6, :name => 'To /<spain/>Hasta', :toggle_option => 'With <plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_saturday.id, :toggle_option => 'Saturday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 6, :name => 'and /<spain/>y', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'

field_for_mandatory_sunday = current_step.fields.create :field_type => 'checkbox', :name => 'Sunday /<spain/>Domingo', :toggle_id => toggle_id, :toggle_option => 'With <plaintiff_full_name>', :sub_toggle_id => toggle_id + 7, :insert_place => '2', :mandatory => { :value => /1/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 7, :name => 'From /<spain/>Desde', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 7, :name => 'To /<spain/>Hasta', :toggle_option => 'With <plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_sunday.id, :toggle_option => 'Sunday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 7, :name => 'and /<spain/>y', :toggle_option => 'With <plaintiff_full_name>', :insert_place => '2'

current_step.fields.create :field_type => 'text', :name => 'Visitation with <plaintiff_full_name> will be /<spain/>Las visitas con el <plaintiff_full_name> serán:', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => '<plaintiff_full_name> days off /<spain/><plaintiff_full_name> los días de descanso', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => '1 Weekend a month /<spain/>1 fin de semana al mes', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => 'Every Other Weekend /<spain/>Fin de semana por medio', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'checkbox', :name => 'Every weekend /<spain/>Todos los fin de semana', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
field_for_mandatory_monday = current_step.fields.create :field_type => 'checkbox', :name => 'Monday /<spain/>Lunes', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :sub_toggle_id => toggle_id + 1, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 1, :name => 'From /<spain/>Desde', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 1, :name => 'To /<spain/>Hasta', :toggle_option => 'With <defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_monday.id, :toggle_option => 'Monday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 1, :name => 'and /<spain/>y', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'

field_for_mandatory_tuesday = current_step.fields.create :field_type => 'checkbox', :name => 'Tuesday /<spain/>Martes', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :sub_toggle_id => toggle_id + 2, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 2, :name => 'From /<spain/>Desde', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 2, :name => 'To /<spain/>Hasta', :toggle_option => 'With <defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_tuesday.id, :toggle_option => 'Tuesday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 2, :name => 'and /<spain/>y', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'

field_for_mandatory_wednesday = current_step.fields.create :field_type => 'checkbox', :name => 'Wednesday /<spain/>Miércoles', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :sub_toggle_id => toggle_id + 3, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 3, :name => 'From /<spain/>Desde', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 3, :name => 'To /<spain/>Hasta', :toggle_option => 'With <defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_wednesday.id, :toggle_option => 'Wednesday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 3, :name => 'and /<spain/>y', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'

field_for_mandatory_thursday = current_step.fields.create :field_type => 'checkbox', :name => 'Thursday /<spain/>Jueves', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :sub_toggle_id => toggle_id + 4, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 4, :name => 'From /<spain/>Desde', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 4, :name => 'To /<spain/>Hasta', :toggle_option => 'With <defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_thursday.id, :toggle_option => 'Thursday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 4, :name => 'and /<spain/>y', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'

field_for_mandatory_friday = current_step.fields.create :field_type => 'checkbox', :name => 'Friday /<spain/>Viernes', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :sub_toggle_id => toggle_id + 5, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 5, :name => 'From /<spain/>Desde', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 5, :name => 'To /<spain/>Hasta', :toggle_option => 'With <defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_friday.id, :toggle_option => 'Friday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 5, :name => 'and /<spain/>y', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'

field_for_mandatory_saturday = current_step.fields.create :field_type => 'checkbox', :name => 'Saturday /<spain/>Sábado', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :sub_toggle_id => toggle_id + 6, :insert_place => '2'

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 6, :name => 'From /<spain/>Desde', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 6, :name => 'To /<spain/>Hasta', :toggle_option => 'With <defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_saturday.id, :toggle_option => 'Saturday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 6, :name => 'and /<spain/>y', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'

field_for_mandatory_sunday = current_step.fields.create :field_type => 'checkbox', :name => 'Sunday /<spain/>Domingo', :toggle_id => toggle_id, :toggle_option => 'With <defendant_full_name>', :sub_toggle_id => toggle_id + 7, :insert_place => '2', :mandatory => { :value => /1/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 7, :name => 'From /<spain/>Desde', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 7, :name => 'To /<spain/>Hasta', :toggle_option => 'With <defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_sunday.id, :toggle_option => 'Sunday' }, :insert_place => '2'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 7, :name => 'and /<spain/>y', :toggle_option => 'With <defendant_full_name>', :insert_place => '2'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 6, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_saturday.id, :toggle_option => 'Saturday' }, :insert_place => '3'
current_step.fields.create :field_type => 'checkbox', :name => '1st and 3rd week with <plaintiff_full_name> and 2nd and 4th week with <defendant_full_name> /<spain/>1ra y 3ra semana con <plaintiff_full_name> y 2da y 4ta semana con <defendant_full_name>', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'checkbox', :name => '2nd and 4th week with <plaintiff_full_name> and 1st and 3rd week with <defendant_full_name> /<spain/>2da y 4ta semana con <plaintiff_full_name> y 1ra y 3ra semana con <defendant_full_name>', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :insert_place => '3'
field_for_mandatory_monday = current_step.fields.create :field_type => 'checkbox', :name => 'Monday /<spain/>Lunes', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :sub_toggle_id => toggle_id + 1, :insert_place => '3'


current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 1, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_monday.id, :toggle_option => 'Monday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 1, :name => 'From /<spain/>Desde', :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 1, :name => 'To /<spain/>Hasta', :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_monday.id, :toggle_option => 'Monday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 1, :name => 'and /<spain/>y', :toggle_option => 'Both Parents', :insert_place => '3'

field_for_mandatory_tuesday = current_step.fields.create :field_type => 'checkbox', :name => 'Tuesday /<spain/>Martes', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :sub_toggle_id => toggle_id + 2, :insert_place => '3'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 2, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_tuesday.id, :toggle_option => 'Tuesday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 2, :name => 'From /<spain/>Desde', :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 2, :name => 'To /<spain/>Hasta', :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_tuesday.id, :toggle_option => 'Tuesday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 2, :name => 'and /<spain/>y', :toggle_option => 'Both Parents', :insert_place => '3'

field_for_mandatory_wednesday = current_step.fields.create :field_type => 'checkbox', :name => 'Wednesday /<spain/>Miércoles', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :sub_toggle_id => toggle_id + 3, :insert_place => '3'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 3, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_wednesday.id, :toggle_option => 'Wednesday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 3, :name => 'From /<spain/>Desde', :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 3, :name => 'To /<spain/>Hasta', :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_wednesday.id, :toggle_option => 'Wednesday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 3, :name => 'and /<spain/>y', :toggle_option => 'Both Parents', :insert_place => '3'

field_for_mandatory_thursday = current_step.fields.create :field_type => 'checkbox', :name => 'Thursday /<spain/>Jueves', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :sub_toggle_id => toggle_id + 4, :insert_place => '3'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 4, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_thursday.id, :toggle_option => 'Thursday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 4, :name => 'From /<spain/>Desde', :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 4, :name => 'To /<spain/>Hasta', :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_thursday.id, :toggle_option => 'Thursday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 4, :name => 'and /<spain/>y', :toggle_option => 'Both Parents', :insert_place => '3'

field_for_mandatory_friday = current_step.fields.create :field_type => 'checkbox', :name => 'Friday /<spain/>Viernes', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :sub_toggle_id => toggle_id + 5, :insert_place => '3'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 5, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_friday.id, :toggle_option => 'Friday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 5, :name => 'From /<spain/>Desde', :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 5, :name => 'To /<spain/>Hasta', :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_friday.id, :toggle_option => 'Friday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 5, :name => 'and /<spain/>y', :toggle_option => 'Both Parents', :insert_place => '3'

field_for_mandatory_saturday = current_step.fields.create :field_type => 'checkbox', :name => 'Saturday /<spain/>Sábado', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :sub_toggle_id => toggle_id + 6, :insert_place => '3'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 6, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_saturday.id, :toggle_option => 'Saturday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 6, :name => 'From /<spain/>Desde', :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 6, :name => 'To /<spain/>Hasta', :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_saturday.id, :toggle_option => 'Saturday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 6, :name => 'and /<spain/>y', :toggle_option => 'Both Parents', :insert_place => '3'

field_for_mandatory_sunday = current_step.fields.create :field_type => 'checkbox', :name => 'Sunday /<spain/>Domingo', :toggle_id => toggle_id, :toggle_option => 'Both Parents', :sub_toggle_id => toggle_id + 7, :insert_place => '3', :mandatory => { :value => /1/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id + 7, :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor', :template_field => field_for_mandatory_sunday.id, :toggle_option => 'Sunday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 7, :name => 'From /<spain/>Desde', :toggle_option => 'Both Parents', :insert_place => '3'
current_step.fields.create :field_type => 'day_of_week', :toggle_id => toggle_id + 7, :name => 'To /<spain/>Hasta', :toggle_option => 'Both Parents', :mandatory => { :value => /\w+/, :hint => 'Provide a day of week /<spain/>Por favor, proporcionar un día de la semana', :template_field => field_for_mandatory_sunday.id, :toggle_option => 'Sunday' }, :insert_place => '3'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id + 7, :name => 'and /<spain/>y', :toggle_option => 'Both Parents', :insert_place => '3'


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes',#19
                                     :title => 'Holiday /<spain/>Feriados',
                                     :description => 'Do you want to discuss holidays at this time?<spain/>¿Quieres hablar de horario festivo en este momento?'
toggle_id = 0
toggle_id += 1
children_holidays_now = current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step.fields.create :field_type => 'text review_show', :name => 'Do you want all children to have the same holiday schedule?
                                                            <br/><spain/>¿Quiere que todos los menores tengan el mismo horario de vacaciones?', :toggle_id => toggle_id, :toggle_option => 'Yes', :render_if_id => children_amount_field.id.to_s, :render_if_value => /\A[^1]{1}/

same_schedule = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                                             <option/>No', :toggle_id => toggle_id, :toggle_option => 'Yes', :render_if_id => children_amount_field.id.to_s, :render_if_value => /\A[^1]{1}/, :sub_toggle_id => toggle_id + 1



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_holidays_now.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, :amount_field_if => same_schedule.id, :amount_field_if_option => 'No',#20
                                     :title => 'Holiday /<spain/>Feriados',
                                     :description => 'Check all the holiday that apply for your <child_count>:<br/><spain/>Marque todos los feriados que aplican para su <child_count_spain>:'

current_step.fields.create :field_type => 'text review_show', :name => 'Holidays schedule for <insert><spain/>Holidays schedule para <insert>', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'New Year’s Eve from /<spain/>Víspera de año nuevo desde', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'New Year’s Day /<spain/>Año Nuevo', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Martin Luther King, Jr. Day /<spain/>Día  de Martin Luther King, Jr.', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'President’s day /<spain/>Día de los Presidentes', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Passover', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Easter /<spain/>Pascua', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Memorial Day', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Mother’s Day /<spain/>Día de la Madre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to, with mom every year /<spain/>hasta, con la madre todos los años'


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other Country Mother’s Day /<spain/>Día de la Madre (de otro país)', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to, with mom every year /<spain/>hasta, con la madre todos los años'


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Father’s day /<spain/>Día del Padre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to, with dad every year /<spain/>hasta, con el padre todos los años'


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other Country Father’s Day /<spain/>Día del Padre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to, with dad every year /<spain/>hasta, con el padre todos los años'





current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_holidays_now.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, :amount_field_if => same_schedule.id, :amount_field_if_option => 'No',#21
                                     :title => 'More Holiday /<spain/>Más Feriados',
                                     :description => 'Check all the holiday that apply for your <child_count>:<br/>
                                                      <spain/>Marque todos los feriados que aplican para su <child_count_spain>:'

current_step.fields.create :field_type => 'text review_show', :name => 'More Holidays schedule for <insert><spain/>Más Holidays schedule para <insert>', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => '4th of July /<spain/>4 de Julio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Labor Day /<spain/>Día del trabajador', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Rosh Hashanah /<spain/>Rosh Hashanah', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Yom Kippur', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Nevada Day /<spain/>Día de Nevada', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Halloween', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Veteran’s Day /<spain/>Día de los Veteranos', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Thanksgiving Day /<spain/>Día de Acción de Gracias', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Christmas Eve /<spain/>Víspera de noche de Navidad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Christmas /<spain/>Navidad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name><option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Father’s Birthday /<spain/>Cumpleaños del Padre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to, with dad every year /<spain/>hasta, con el padre todos los años'


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Mother’s Birthday /<spain/>Cumpleaños de la Madre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to, with mom every year /<spain/>hasta, con la madre todos los años'


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Child’s Birthday /<spain/>Cumpleaños del menor', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Chinese  New Year’s /<spain/>Año Nuevo Chino', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Chanukkah', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Spring Break /<spain/>Vacaciones de primavera', :toggle_id => toggle_id
current_step.fields.create :field_type => 'radio-last', :name => 'all /<spain/>Todo la vacacion
                                                                  <option/>portion /<spain/>porcion de la vacacion con', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                             <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>odd years /<spain/>año impares
                                                             <option/>even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Winter Break /<spain/>Vacaciones de invierno', :toggle_id => toggle_id
current_step.fields.create :field_type => 'radio-last', :name => 'all /<spain/>Todo la vacacion
                                                                  <option/>portion /<spain/>porcion de la vacacion con', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                             <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>odd years /<spain/>año impares
                                                             <option/>even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Summer Break /<spain/>Vacaciones de verano', :toggle_id => toggle_id
current_step.fields.create :field_type => 'radio-last', :name => 'all /<spain/>Todo la vacacion
                                                                  <option/>portion /<spain/>porcion de la vacacion con', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                             <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>odd years /<spain/>año impares
                                                             <option/>even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other Holiday /<spain/>Otro Feriado', :toggle_id => toggle_id
current_step.fields.create :name => 'Holiday Name /<spain/>Holiday Nombre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter holiday name /<spain/>Por favor, ponga el feriado' }
current_step.fields.create :field_type => 'date', :toggle_id => toggle_id, :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date /<spain/>Por favor, ponga la fecha' }
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name>
                                                                  <option/><defendant_full_name>', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

#                 END OF HOLIDAY

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes',#22
                                     :title => '<child_count> Health Insurance /<spain/>Seguro Médico <child_count_spain> ',
                                     :description => 'Who will be responsible for maintaining health and dental insurance for <child_count>? /
                                                      <spain/>¿Quién será responsable de mantener el seguro médico y dental para <child_count_spain>?'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name><option/><defendant_full_name><option/>Both Parents /<spain/>Ambos Padres', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => custody_field.id.to_s, :render_if_field_value => 'With|Only',#23
                                     :title => '<child_count> Support /<spain/>Manutención <child_count_spain>'

child_support_field = current_step.fields.create :field_type => 'radio', :name => 'I already have a child support case with the DA office /<spain/>Ya tengo un caso de manutención de menor con la oficina del distrito
                                                             <option/>No <child> support /<spain/>No habrá manutención <child_count_spain>
                                                             <option/><defendant_full_name> will pay <child> support /<spain/><defendant_full_name> pagara manutención para los menores
                                                             <option/><plaintiff_full_name> will pay <child> support /<spain/><plaintiff_full_name> pagara manutención para', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'text', :name => 'Because you requested sole/primary physical custody your <child_sole_count> /<spain/>Porque usted pidio la custodia física primary/sole de <child_sole_count_spain>.', :toggle_id => toggle_id, :toggle_option => 'will'

current_step.fields.create :field_type => 'radio', :name => '<defendant_full_name> will pay the statutory <child_percentage_sole>, of his gross income to <plaintiff_full_name> /<spain/><defendant_full_name> pagara bajo la ley el <child_percentage_sole_spain>, de sus ingresos brutos.
                                                             <option/><defendant_full_name> will pay the following amount $ /<spain/><defendant_full_name> pagara la siguiente cantidad $', :toggle_id => toggle_id, :sub_toggle_id => toggle_id + 1, :toggle_option => '<defendant_full_name>', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

field_for_mandatory = current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will pay the percentage under the law of <child_percentage_sole> of the non-custodial parent’s gross monthly income/<spain/><plaintiff_full_name> pagara la el porcentaje bajo la ley <child_percentage_sole_spain> del ingreso bruto mensual de los padres sin custodia
                                                                                   <option/><plaintiff_full_name> will pay the following amount $ /<spain/>La mamá pagara la siguiente cantidad $', :toggle_id => toggle_id, :sub_toggle_id => toggle_id + 1, :toggle_option => '<plaintiff_full_name>', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

toggle_id += 1
current_step.fields.create :field_type => 'amount $', :name => 'per month as <child_count> support /<spain/>mensual de manutención para <child_count_spain>', :toggle_id => toggle_id, :toggle_option => 'amount', :mandatory => { :value => /^(\$)[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto', :template_field => field_for_mandatory.id, :toggle_option => 'amount' }



toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => custody_field.id.to_s, :render_if_field_value => 'Both Parents',#24
                                     :title => '<child_count> Support /<spain/>Manutención <child_count_spain>'

current_step.fields.create :field_type => 'text', :name => 'Because you requested joint physical custody your <child_joint_count> /<spain/>Porque usted pido la custodia física conjunta de <child_joint_count_spain>.'
current_step.fields.create :field_type => 'text', :name => 'Child support is determine based on Gross Monthly Income of both parents /<spain/>La manutención de menor se determinar en base a los ingresos brutos mensuales de los dos padres.'

current_step.fields.create :field_type => 'amount-income', :name => 'Enter $ <plaintiff_full_name>’s average gross monthly income /<spain/>Pogna $ el promedio de ingreso mensual bruto de <plaintiff_full_name>', :mandatory => { :value => /^[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto' }
current_step.fields.create :field_type => 'amount-income', :name => 'Enter $ <defendant_full_name>’s average gross monthly income /<spain/>Ponga el promedio de ingreso mensual bruto del <defendant_full_name>', :mandatory => { :value => /^[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto' }



toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes',#25
                                     :title => 'Additional Child Support Question /<spain/>Preguntas Adiciones sobre Manutencion de Menores'
current_step.fields.create :field_type => 'text review_show', :name => 'Are you currently employed or self-employed? /<spain/>¿Actualmente tiene empleo o trabaja por su cuenta? *'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                             <option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'string capitalize review_show default_no', :name => 'Employer Name /<spain/>Nombre del empleador  *', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string capitalize review_show', :name => 'Business Address /<spain/>Dirección del Negocio: *', :mandatory => { :value => /^([0-9a-zA-Z\-,.\/ #]+)?$/, :hint => 'Please enter a valid home address /<spain/>Por favor, ponga una dirección de casa o postal válida' }, :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string capitalize rev_inline', :name => 'City /<spain/>Ciudad: *', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }, :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'states rev_inline', :name => 'State /<spain/>Estado: *', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }, :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string rev_inline', :name => 'Zip Code /<spain/>Código postal: * ', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string review_show default_no', :name => 'Phone number /<spain/>Número de teléfono:', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string review_show default_no rev_br', :name => 'Driver’s License #<spain/>/ Número de licencia de conducir:', :toggle_id => toggle_id, :toggle_option => 'Yes'

current_step.fields.create :field_type => 'text review_show', :name => 'Your Ethnicity /<spain/>Su Raza: *'
current_step.fields.create :field_type => 'radio', :name => 'White (Non-Hispanic) /<spain/>Blanco (No Latino)
                                                             <option/>Hispanic /<spain/>Latino
                                                             <option/>African-American /<spain/>Afro -Americano
                                                             <option/>Asian or Pacific Islander /<spain/>Asiático o Islas del Pacifico
                                                             <option/>Native American or Alaskan Native /<spain/>Indígena Americano o Nativo de Alaska
                                                             <option/>Other /<spain/>Otra', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes',#26
                                     :title => 'Additional Child Support Question for Spouse /<spain/>Preguntas Adiciones de su cónyuge sobre la Manutencion de Menores'
current_step.fields.create :field_type => 'text review_show', :name => 'Is your spouse currently employed? /<spain/>¿Actualmente está su cónyuge trabajando? *'
current_step.fields.create :field_type => 'radio rev_br', :name => 'I don’t know /<spain/>No sé
                                                             <option/>No
                                                             <option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'string capitalize review_show default_no', :name => 'Employer Name /<spain/>Nombre del empleador  *', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string capitalize review_show', :name => 'Business Address /<spain/>Dirección del Negocio: *', :mandatory => { :value => /^([0-9a-zA-Z\-,.\/ #]+)?$/, :hint => 'Please enter a valid home address /<spain/>Por favor, ponga una dirección de casa o postal válida' }, :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string capitalize rev_inline', :name => 'City /<spain/>Ciudad: *', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }, :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'states rev_inline', :name => 'State /<spain/>Estado: *', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }, :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string rev_inline', :name => 'Zip Code /<spain/>Código postal: * ', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string review_show default_no', :name => 'Phone number /<spain/>Número de teléfono:', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'string review_show default_no rev_br', :name => 'Driver’s License #<spain/>/ Número de licencia de conducir:', :toggle_id => toggle_id, :toggle_option => 'Yes'

current_step.fields.create :field_type => 'text review_show', :name => 'Your Spouse Ethinicity /<spain/>Raza de su cónyuge: *'
current_step.fields.create :field_type => 'radio', :name => 'White (Non-Hispanic) /<spain/>Blanco (No Latino)
                                                             <option/>Hispanic /<spain/>Latino
                                                             <option/>African-American /<spain/>Afro -Americano
                                                             <option/>Asian or Pacific Islander /<spain/>Asiático o Islas del Pacifico
                                                             <option/>Native American or Alaskan Native /<spain/>Indígena Americano o Nativo de Alaska
                                                             <option/>Other /<spain/>Otra', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes',#27
                                     :title => 'Wage Withholding /<spain/>Retención de Sueldo'


current_step.fields.create :field_type => 'text', :name => 'Are you requesting wage withholding to collect <child_count> support?
                                                            <br/><spain/>¿Está pidiendo retención de salario para cobrar la manutención de <child_count_spain>?'

current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                             <option/>No<option/>No, child support is already being collected by the DA /<spain/>No, la oficina de manutención ya lo está haciendo', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes',#28
                                     :title => '<child_count> Support Arrears /<spain/>Manutención <child_count_spain> Retroactiva'

current_step.fields.create :field_type => 'text', :name => 'You can request up to 4 years of back <child_count> support. <br/><spain/>Puede pedir hasta 4 años atrasados de manutención de <child_count_spain>.'

current_step.fields.create :field_type => 'text', :name => 'Are you requesting <child_count> support ARREARS? <br/><spain/>¿Está solicitando manutención ATRASADA de <child_count_spain>?'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                             <option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'date_without_day start_range=-5 review_show', :name => 'I want back <child_count> support starting /<spain/>Quiero la manutención de <child_count_spain> a partir', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please select date /<spain/>Por favor seleccione la fecha' }
current_step.fields.create :field_type => 'text review_show', :name => 'I want /<spain/>Quiero', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'amount $ review_show', :name => 'per month for child support /<spain/>por mes de manutención de menores', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^(\$)?[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto' }

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => continue_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id,#29
                                     :title => '<child_count> Tax Exemption /<spain/>En los Impuestos <child_count_spain>'

current_step.fields.create :field_type => 'text review_show', :name => 'Who will claim <insert> as dependent on tax returns?<br/><spain/>¿Quién reclamará <insert> como dependiente en los impuestos?', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
current_step.fields.create :field_type => 'radio', :name => 'Should be allocated per federal law /<spain/>Sea asignada por ley federal
                                                             <option/><plaintiff_full_name> every year /<spain/><plaintiff_full_name> todos los años
                                                             <option/><defendant_full_name> every year /<spain/><defendant_full_name> todos los años
                                                             <option/><defendant_full_name> and <plaintiff_full_name> alternating years /<spain/><plaintiff_full_name> y <defendant_full_name> años por medio', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'date_year_only start_range=-1 review_show', :name => '<plaintiff_full_name> will start claiming the child from /<spain/><plaintiff_full_name> comenzara a reclamar el menor desde:', :toggle_id => toggle_id, :toggle_option => 'alternating years', :mandatory => { :value => /\w+/, :hint => 'Please select date /<spain/>Seleccione uno, por favor' }

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1,#30
                                     :title => 'Pet /<spain/>Mascota',
                                     :description => 'Do you have pets that you would like the court to give you custody of?
                                                      <spain/>¿Va a pedir la custodia de sus mascotas en la corte?'

pet_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                                         <option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

pet_amount_field = current_step.fields.create :field_type => 'amount', :name => 'How many: /<spain/>Cuántos:', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^[1-9]{1}$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => pet_field.id.to_s, :render_if_field_value => 'Yes', :amount_field_id => pet_amount_field.id,#31
                                     :title => 'Pet Custody /<spain/>Custodia de Mascota'

current_step.fields.create :name => 'Name of your Pet: *
                                     <spain/>Nombre de su mascota:*', :mandatory => { :value => /\w+/, :hint => 'Please enter a valid pet name /<spain/>Por favor, ponga un nombre válido de mascota' }, :field_type => 'string-capitalize'

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/>Se QUEDARA con <plaintiff_full_name>
                                                             <option/><defendant_full_name> will keep /<spain/>Se QUEDARA con <defendant_full_name>
                                                             <option/>Both Equally /<spain/>AMBOS TENDREMOS custodia ', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



#
# PROPERTY DIVISION
#


current_step = template.steps.create :step_number => step_number += 1,#32
                                     :title => 'Property /<spain/>Bienes',
                                     :description => 'Nevada is a community property state, regardless of your immigration status. This means that the law presumes that all property (bank account, 401K, house, military pension, car, furniture, jewelry, etc.) acquired or incurred during the marriage is community property, and belongs equally to both parties, with the exception of separate property.
                                                      <br/><spain/>Nevada es un estado de propiedad comunitaria, no importa su estatus migratorio. Esto significa que la ley presupone que todas las propiedades (cuenta bancaria, 401 k, casa, pensión militar, carro, muebles, joyería, etc.) adquiridas o compradas durante el matrimonio son bienes comunitarios y pertenece igualmente a ambas partes, con la excepción de la propiedad individual.'

current_step.fields.create :field_type => 'text', :name => 'Do you have community property to divide?
                                                            <br/><spain/>¿Tienen propiedad en común que dividir?'

property_division_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No<option/>No, we already divided them /<spain/>No ya las dividimos', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

toggle_id = 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id.to_s, :render_if_field_value => 'Yes',#33
                                     :title => 'Property Division: Home/Mobile home/land/Business /<spain/>División de Propiedad: Casa/lote/Negocio',
                                     :description => 'What did you buy during the marriage and need to be divided?
                                                      <br/><spain/>¿Qué compraron durante el matrimonio se tiene que dividir?'

current_step.fields.create :field_type => 'checkbox', :name => 'House - Mobile Home /<spain/>Casa - Traila', :toggle_id => toggle_id, :sort_index => 'a1'
house_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'House - Mobile Home/Casa - Traila<beginText/>Address /<spain/>Dirección:', :amount_field_id => house_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con ella', :amount_field_id => house_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over a quitclaim deed to the property?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> le firme el quitclaim deed o título de la propiedad?', :sort_index => 'b1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'b2'

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Empty land /<spain/>Lote-Tierra', :toggle_id => toggle_id, :sort_index => 'c1'
land_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Empty land/Lote-Tierra<beginText/>Address /<spain/>Dirección:', :amount_field_id => land_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con ella', :amount_field_id => land_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over a quitclaim deed to the property?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> le firme el quitclaim deed o título de la propiedad?', :sort_index => 'd1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'd2'

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Business /<spain/>Negocio', :toggle_id => toggle_id, :sort_index => 'e1'
business_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'e2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Business/Negocio<beginText/>Name of the business /<spain/>Nombre del negocio:', :amount_field_id => business_number_field.id, :raw_question => false, :toggle_id => toggle_id, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Address /<spain/>Dirección:', :amount_field_id => business_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio-last', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con ella', :amount_field_id => business_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over a quitclaim deed to the property?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> le firme el quitclaim deed o título de la propiedad?', :sort_index => 'f1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'f2'

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id.to_s, :render_if_field_value => 'Yes',#35
                                     :title => 'Property Division: Vehicles /<spain/>División de Propiedades: Vehículos',
                                     :description => 'Was there a car, motorcycle, rv, boat, trailer purchased during the marriage?
                                                      <br/><spain/>¿Compraron carro, moto, rv, barco, remolque durante el matrimonio?'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Car /<spain/>Carro', :toggle_id => toggle_id, :sort_index => 'a1'
car_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :field_type => 'string capitalize', :name => 'Car/Carro<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con el
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con el', :toggle_id => toggle_id, :amount_field_id => car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over vehicle title to you?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> su cónyuge le firme el título de vehículo?', :sort_index => 'b1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'b2'

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Motorcycle /<spain/>Motocicleta', :toggle_id => toggle_id, :sort_index => 'c1'
motorcycle_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :field_type => 'string capitalize', :name => 'Motorcycle/Motocicleta<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con ella', :toggle_id => toggle_id, :amount_field_id => motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over vehicle title to you?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> su cónyuge le firme el título de vehículo?', :sort_index => 'd1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'd2'

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'RV', :toggle_id => toggle_id, :sort_index => 'e1'
rv_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'e2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :field_type => 'string capitalize', :name => 'RV/RV<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con ella', :toggle_id => toggle_id, :amount_field_id => rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over vehicle title to you?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> su cónyuge le firme el título de vehículo?', :sort_index => 'f1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'f2'

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Boat /<spain/>Barco', :toggle_id => toggle_id, :sort_index => 'g1'
boat_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'g2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :field_type => 'string capitalize', :name => 'Boat/Barco<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con el
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con el', :toggle_id => toggle_id, :amount_field_id => boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over vehicle title to you?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> su cónyuge le firme el título de vehículo?', :sort_index => 'h1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'h2'

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Trailer /<spain/>Remolque', :toggle_id => toggle_id, :sort_index => 'i1'
trailer_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'i2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :field_type => 'string capitalize', :name => 'Trailer/Remolque<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => trailer_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con el
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con el', :toggle_id => toggle_id, :amount_field_id => trailer_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'label', :name => 'Do you need <defendant_full_name> to sign over vehicle title to you?
                                                            <br/><spain/>¿Necesita que <defendant_full_name> su cónyuge le firme el título de vehículo?', :sort_index => 'j1'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :sort_index => 'j2'

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other /<spain/>Otro', :toggle_id => toggle_id, :sort_index => 'k1'
other_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'k2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :field_type => 'string capitalize', :name => 'Other/Otro<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => other_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con ella', :toggle_id => toggle_id, :amount_field_id => other_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }







current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id.to_s, :render_if_field_value => 'Yes',#36
                                     :title => 'Property Division: Pension Benefit /<spain/>División de Beneficios de Pensión',
                                     :description => 'Is there a pension benefit, retirement fund, 401K, 403B, military pension, other retirement benefits obtain during the marriage?
                                                      <br/><spain/>¿Hay beneficio de Pensión, 401 k, 403B, pensión militar, otros beneficios de jubilación durante a matrimonio?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /^Yes|No$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sort_index => 'a1'
plan_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :field_type => 'string review_show capitalize', :name => 'Retirement plan /Plan de Retiro<beginText/>Name of the plan: /<spain/>Nombre del plan de beneficios:', :toggle_id => toggle_id, :amount_field_id => plan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter name of the plan /<spain/>Por favor ingrese el nombre del plan' }, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con el
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con el', :toggle_id => toggle_id, :amount_field_id => plan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sub_toggle_id => toggle_id + 1, :toggle_option => 'Yes'


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id.to_s, :render_if_field_value => 'Yes',#37
                                     :title => 'Property Division: Bank and Investment Account /<spain/>División de Cuentas Bancarias e Inversiones',
                                     :description => 'Is there bank accounts, investment account or any other financial account obtain during the marriage?
                                                      <br/><spain/>¿Hay cuentas bancarias, de inversiones, u otro tipo de cuenta financiera obtenida  durante el matrimonio?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /^Yes|No$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sort_index => 'a1'
bank_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Account/Cuenta<beginText/>Name of the account /<spain/>Nombre de la cuenta', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter name of the account /<spain/>Por favor introduce el nombre de la cuenta' }, :field_type => 'string-capitalize', :toggle_option => 'Yes'
current_step.fields.create :name => 'approximate amount in it /<spain/>la cantidad aproximada', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter approximate amount in it /<spain/>Por favor, ingrese el monto aproximado en ella' }, :toggle_option => 'Yes', :field_type => 'string $'
current_step.fields.create :name => 'last 4# (if possible) /<spain/>los últimos 4# (si es posible):', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter last 4# /<spain/>Por favor introduce el pasado 4 #' }, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'radio', :toggle_option => 'Yes', :name => '<plaintiff_full_name> will keep it /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep it /<spain/><defendant_full_name> se quedara con ella', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sub_toggle_id => toggle_id + 1


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id.to_s, :render_if_field_value => 'Yes',#38
                                     :title => 'Property Division: Other /<spain/>División de Bienes: Otro',
                                     :description => 'Is there anything else bought during the marriage that you want to keep?
                                                      <br/><spain/>¿Compro algo más durante el matrimonio que desea quedarse?'

current_step.fields.create :field_type => 'checkbox review_show', :name => 'Other Property Division /<spain/>Otra división de Bienes', :sort_index => 'a1', :toggle_id => toggle_id
other_property_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Description /Descripción<beginText/>', :toggle_id => toggle_id, :amount_field_id => other_property_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter value /<spain/>Por favor introduce el valor' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> se quedara con ella
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> se quedara con ella', :toggle_id => toggle_id, :amount_field_id => other_property_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

#
# END OF PROPERTY DIVISION
#



#
# DEBTS
#


current_step = template.steps.create :step_number => step_number += 1,#39
                                     :title => 'Debts /<spain/>Deudas',
                                     :description => 'Do you have community debts to divide?
                                                      <br/><spain/>¿Tienen deudas en común que dividir?'

current_step.fields.create :field_type => 'text', :name => 'Nevada is a community property state, regardless of your immigration status. This means that the law presumes that all debts (credit cards, loans, mortgage, taxes, hospital bills, etc.) acquired or incurred during the marriage is community debts, and belongs equally to both parties, with the exception of separate debt.
                                                            <br/><spain/>Nevada es un estado de propiedad comunitaria, no importa su estatus migratorio. Esto significa que la ley presupone que todas las deudas (tarjetas de crédito, préstamos, impuestos, cuenta de hospital, etc.) adquiridas o incurridas durante el matrimonio son responsabilidad de ambas partes y pertenecen igualmente a los dos, con la excepción de deudas individuales.'

debts_division_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                                                    <option/>No<option/>No, we already divided them /<spain/>No ya las dividimos', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id.to_s, :render_if_field_value => 'Yes',#40
                                     :title => 'Debts Division: Mortgages /<spain/>División de Deudas: Hipotecas',
                                     :description => 'Do you have any of these loans to divide?
                                                      <br/><spain/>¿Tienen algunas de estos préstamos que dividir?'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'House - Mobile Home /<spain/>Casa - Traila', :toggle_id => toggle_id, :sort_index => 'a1'
debt_house_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'House - Mobile Home /Casa- Traila <beginText/>Address /<spain/>Dirección:', :amount_field_id => debt_house_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Bank and amount owe /<spain/>Banco y cantidad que se debe:', :toggle_id => toggle_id, :amount_field_id => debt_house_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter bank and amount owe /<spain/>Por favor, introduzca banco y la cantidad deben' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                                                    <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar
                                                                                    <option/>Pay with sell of home /<spain/>Pagar con venta de casa', :toggle_id => toggle_id, :amount_field_id => debt_house_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Empty land /<spain/>Lote-Tierra', :toggle_id => toggle_id, :sort_index => 'b1'
debt_land_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Empty land/Lote-Tierra<beginText/>Address /<spain/>Dirección:', :amount_field_id => debt_land_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Bank and amount owe /<spain/>Banco y cantidad que se debe:', :toggle_id => toggle_id, :amount_field_id => debt_land_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter bank and amount owe /<spain/>Por favor, introduzca banco y la cantidad deben' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                                                    <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar
                                                                                    <option/>Pay with sell of land /<spain/>Pagar con venta de lote-tierra', :toggle_id => toggle_id, :amount_field_id => debt_land_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id.to_s, :render_if_field_value => 'Yes',#41
                                     :title => 'Debt Division: Credit Cards, hospital or medical bills
                                                <br/><spain/>División de Deuda: Tarjeta de Crédito, Cuenta de hospital o doctor',
                                     :description => 'Are there any credit cards, hospital or medical bills to divide?
                                                      <br/><spain/>¿Tiene tarjetas de créditos, cuenta de hospital o doctores que dividir?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Credit Cards /<spain/>Tarjetas de crédito', :sort_index => 'a1', :toggle_id => toggle_id
credits_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Credit Cards/Tarjetas de crédito<beginText/>Card, amount, last 4# (if possible): (example Visa, $1000, #1234) /<spain/>Tarjeta, cantidad, últimos 4#: (ejemplo Visa, $ 1000, #1234)', :toggle_id => toggle_id, :amount_field_id => credits_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Card, amount, last 4# /<spain/>Por favor introduce la tarjeta, la cantidad, el pasado 4 #' }

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                            <option/>Divide /<spain/>Dividir
                                                            <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => credits_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Hospital bills /<spain/>Las facturas del hospital', :toggle_id => toggle_id, :sort_index => 'b1'
hospital_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Hospital bills/Las facturas del hospital<beginText/>Hospital bill $ (enter amount) /<spain/>Cuenta de hospital', :toggle_id => toggle_id, :amount_field_id => hospital_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Hospital bill /<spain/>Por favor introduce factura del hospital' }

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                            <option/>Divide /<spain/>Dividir
                                                            <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => hospital_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Doctor bills /<spain/>Facturas del médico', :toggle_id => toggle_id, :sort_index => 'c1'
doctor_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Doctor bills/Facturas del médico<beginText/>Doctor bill $ (enter amount) /<spain/>Cuenta de doctor', :toggle_id => toggle_id, :amount_field_id => doctor_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Doctor bill /<spain/>Por favor introduce proyecto de ley médico' }

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                            <option/>Divide /<spain/>Dividir
                                                            <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => doctor_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id.to_s, :render_if_field_value => 'Yes',#42
                                     :title => 'Debt Division: Car Loan /<spain/>División de Deudas: Préstamo de Carro',
                                     :description => 'Is there any car, rv, boat, motorcycle loan to divide?
                                                      <br/><spain/>¿Tiene algún préstamo de carro, rv, barco, moto que dividir?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Car /<spain/>Carro', :sort_index => 'a1', :toggle_id => toggle_id
debt_car_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Car/Carro<beginText/>Car Amount owe: (example Ford about $10,000) /<spain/>Carro y cantidad que se debe: (ejemplo Ford $10,000)', :toggle_id => toggle_id, :amount_field_id => debt_car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter car amount owe /<spain/>Por favor, ingrese el monto coche debo' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'RV', :sort_index => 'b1', :toggle_id => toggle_id
debt_rv_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'RV/RV<beginText/>RV Amount owe: (example about $10,000) /<spain/>RV y cantidad que se debe: (ejemplo  $10,000)', :toggle_id => toggle_id, :amount_field_id => debt_rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter rv amount owe /<spain/>Por favor, ingrese el monto rv debo' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Boat /<spain/>Barco', :sort_index => 'c1', :toggle_id => toggle_id
debt_boat_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Boat/Barco<beginText/>Boat Amount owe: (example about $10,000) /<spain/>Barco cantidad que se debe: (ejemplo 10,000)', :toggle_id => toggle_id, :amount_field_id => debt_boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter boat amount owe /<spain/>Por favor, ingrese el monto barco debo' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Motorcycle /<spain/>Moto', :sort_index => 'd1', :toggle_id => toggle_id
debt_motorcycle_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'd2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Motorcycle/Moto<beginText/>Motorcycle Amount owe: (example Honda about $10,000) /<spain/>Moto y cantidad que se debe: (ejemplo Honda $10,000)', :toggle_id => toggle_id, :amount_field_id => debt_motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter motorcycle amount owe /<spain/>Por favor, ingrese el monto de la motocicleta le debe' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id.to_s, :render_if_field_value => 'Yes',#43
                                     :title => 'Debt division: student loans, IRS, payday loans, other /<spain/>División de deuda: préstamo estudiantil, irs, otra deuda',
                                     :description => 'Is there any student loan, IRS, payday loans, other debt to divide?
                                                      <br/><spain/>¿Tiene algún préstamo estudiantil, IRS, otra deuda para dividir?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Student loan /<spain/>Préstamo estudiantil', :sort_index => 'a1', :toggle_id => toggle_id
student_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Student loan/Préstamo estudiantil<beginText/>Student loan, amount owe: (example $10,000) /<spain/>Préstamo estudiantil  deuda: (ejemplo $10,000)', :toggle_id => toggle_id, :amount_field_id => student_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter student loan, amount owe /<spain/>Por favor introduce préstamo estudiantil, cantidad debo' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => student_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'IRS /<spain/>Impuestos', :sort_index => 'b1', :toggle_id => toggle_id
irs_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'IRS/Impuestos<beginText/>IRS amount owe: (example $10,000) /<spain/>Impuestos deuda: (ejemplo $10,000)', :toggle_id => toggle_id, :amount_field_id => irs_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter IRS amount owe /<spain/>Por favor, ingrese el monto Impuestos le debe' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => irs_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Payday loan /<spain/>Préstamo de Día de pago', :sort_index => 'c1', :toggle_id => toggle_id
payday_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Payday loan/Préstamo de Día de pago<beginText/>Payday loan, amount owe: (example $1,000) /<spain/>Préstamo de Día de pago deuda: (ejemplo $1,000)', :toggle_id => toggle_id, :amount_field_id => payday_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter payday loan, amount owe /<spain/>Por favor introduce préstamo de día de pago, cantidad debo' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => payday_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other loan /<spain/>Otro préstamo', :sort_index => 'd1', :toggle_id => toggle_id
other_loan_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'd2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Other loan/Otro préstamo<beginText/>Loan amount owe: (example $2,000) /<spain/>Préstamo deuda: (ejemplo $2,000)', :toggle_id => toggle_id, :amount_field_id => other_loan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Loan amount owe /<spain/>Por favor, ingrese el monto del préstamo debo' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => other_loan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id.to_s, :render_if_field_value => 'Yes',#44
                                     :title => 'Debt Division: Other /<spain/>División de Deuda: Otro',
                                     :description => 'Is there any other debt incurred during the marriage that you want to divide?
                                                      <br/><spain/>¿Hay otra deuda que fue adquirida durante el matrimonio que desea dividir?'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other Debt Division /<spain/>Otra división de la deuda', :sort_index => 'a1', :toggle_id => toggle_id
other_debt_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Continue" /<spain/>Por favor introduce el recuento o el botón "Continuar"' }
current_step.fields.create :name => 'Description /Descripción<beginText/>(example: Parents $ 300) /<spain/>(ejemplo: Los padres $ 300)', :toggle_id => toggle_id, :amount_field_id => other_debt_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter value /<spain/>Por favor introduce el valor' }
current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> will keep /<spain/><plaintiff_full_name> va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/><defendant_full_name> will keep /<spain/><defendant_full_name> va a pagar', :toggle_id => toggle_id, :amount_field_id => other_debt_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



#
# END OF DEBTS
#




#
# ALIMONY
#


current_step = template.steps.create :step_number => step_number += 1,#45
                                     :title => 'Spousal support or Alimony /<spain/>Manutención de cónyuge',
                                     :description => 'There is no precise formula for awarding spousal support/alimony; it is decided on a case by case basis.
 <br/><spain/>No hay ninguna fórmula precisa para determinar la manutención de esposo(a); se decide caso por caso.'


toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => '<plaintiff_full_name> WILL PAY spousal support /<spain/><plaintiff_full_name> PAGARA manutención en la cantidad de $ por mes.
                                                             <option/><defendant_full_name> WILL PAY spousal support /<spain/><defendant_full_name> PAGARA manutención en la cantidad de $ por mes.', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sub_toggle_id => toggle_id + 1

current_step.fields.create :field_type => 'amount $', :name => 'Enter monthly amount /<spain/>Ingrese el monto mensual', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^(\$)[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto' }
current_step.fields.create :field_type => 'amount', :name => 'For how long ? (enter number) /<spain/>¿Por cuánto tiempo? (ponga en número)', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^[0-9,]+$/, :hint => 'Please enter a number /<spain/>Por favor, introduzca un número' }

current_step.fields.create :field_type => 'radio rev_inline', :name => 'Months /<spain/>Meses
                                                             <option/>Year(s) /<spain/>Año(s)', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sub_toggle_id => toggle_id + 1

current_step.fields.create :field_type => 'text', :name => 'Did <defendant_full_name> filed the I-864 Affidavit of Support filed with U.S. Citizenship and Immigration Services?
                                                            <br/><spain/>¿<defendant_full_name> presento el formulario I-864 Declaración de manutención (Affidavit of Support) con el Servicio de Inmigración?', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :toggle_option => 'Yes', :sub_toggle_id => toggle_id + 1

current_step = template.steps.create :step_number => step_number += 1,#46
                                     :title => 'Name Change/<spain/>Cambio de Apellido'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'Not applicable /<spain/>No aplica
                                                             <option/><plaintiff_full_name> will return to <plaintiff_his_her> former last name /<spain/><plaintiff_full_name> volverá a su apellido de <plaintiff_soltera_soltero> que es
                                                             <option/><defendant_full_name> will return to <defendant_his_her> former last name /<spain/><defendant_full_name> volverá a su apellido de <defendant_soltera_soltero> que es', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :toggle_id => toggle_id, :name => 'Last name will be changed to /<spain/>Apellido se cambiará a', :field_type => 'string-upcase', :toggle_option => 'will return', :mandatory => { :value => /\w+/, :hint => 'Please enter /<spain/>Seleccione, por favor' }



current_step = template.steps.create :step_number => step_number += 1,#47
                                     :title => 'Reason for divorce  /<spain/>Razón por el divorcio',
                                     :description => 'Nevada is a "no fault" divorce state.  This means the person seeking the divorce does not have to prove in court that she or he is entitled to a divorce.
                                                      <br/><spain/>Nevada es un estado de divorcio "sin culpa".  Esto significa que la persona que busca el divorcio no tiene que probar en la corte que él o ella tiene el derecho a divorciarse.'

current_step.fields.create :field_type => 'radio', :name => 'I no longer want to be married /<spain/>Ya no quiero seguir casado porque no nos entendemos
                                                             <option/>I no longer want to be married and have lived separated and apart for over 1 year /<spain/>Ya no quiero seguir casada y hemos vivido separados desde hace más de 1 año', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => packet.id.to_s, :render_if_field_value => 'Joint',#48_JOINT
                                     :title => 'Resident witness /<spain/>Testigo de residencia',
                                     :description => 'A resident witness is someone who will signed an affidavit to confirm that you have been a resident of Nevada for 6 weeks. You will need the following information from your witness: Full name, home address, and year the person moved to Nevada.<br/>
                                     <spain/>Un testigo residente es una persona que va a firmar una declaración jurada confirmando que usted ha vivido en Nevada por las últimas 6 semanas. Necesitará la siguiente información de su testigo: Nombre completo, domicilio y año que la persona se mudó a Nevada.'
current_step.fields.create :field_type => 'string upcase',
                           :name => 'Name /<spain/>Nombre: *',
                           :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter name /<spain/>Escriba el nombre' }
current_step.fields.create :field_type => 'string upcase rev_inline',
                           :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:'
current_step.fields.create :field_type => 'string upcase rev_inline',
                           :name => 'Last Name /<spain/>Apellido: *',
                           :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter last name /<spain/>Escriba el apellido' }

current_step.fields.create :field_type => 'string capitalize',
                           :name => 'Home Address /<spain/>Dirección de casa: *',
                           :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid home address /<spain/>Por favor, ponga una dirección de casa o postal válida' }
current_step.fields.create :field_type => 'string capitalize',
                           :name => 'City /<spain/>Ciudad: *',
                           :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }
current_step.fields.create :field_type => 'states rev_inline',
                           :name => 'State /<spain/>Estado: *',
                           :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }
current_step.fields.create :field_type => 'string rev_inline rev_br',
                           :name => 'Zip Code /<spain/>Código postal: * ',
                           :mandatory => { :value => /^\w+$/, :hint => 'Please enter a valid zip code /<spain/>Por favor, ponga un código postal válido' }

current_step.fields.create :field_type => 'text',
                           :name => 'What is your relationship to <witness_name>witness</witness_name> /<spain/>¿Cuál es su relación con <witness_name>testigo</witness_name>'
current_step.fields.create :field_type => 'radio',
                           :name => 'Friend /<spain/>Amigo(a)
                           <option/>Co-worker /<spain/>Compañero(a) de trabajo
                           <option/>Neighbor /<spain/>Vecino(a)
                           <option/>Family member /<spain/>Familiar
                           <option/>Other /<spain/>Otro',
                           :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' },
                           :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left',
                           :mandatory => { :value => /\w+/, :hint => 'Please enter relation /<spain/>Por favor, ingrese relación' },
                           :toggle_id => toggle_id, :toggle_option => 'Other'

current_step.fields.create :field_type => 'date_without_day end_range=-100 rev_inline',
                           :name => 'What month and year did you meet <witness_name>witness</witness_name> in Nevada. /<spain/>¿Qué mes y año usted conoció a <witness_name>testigo</witness_name> en Nevada?',
                           :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please select date /<spain/>Por favor seleccione la fecha' }

current_step.fields.create :field_type => 'text',
                           :name => 'How many times per week do you see <witness_name>witness</witness_name>? /<spain/>¿Cuántas veces por semana ver a <witness_name>testigo</witness_name>?'
current_step.fields.create :field_type => 'amount',
                           :mandatory => { :value => /^[0-7]{1}$/, :hint => 'Please enter 0..7 /<spain/>Por favor, ingrese 0..7' }

current_step.fields.create :field_type => 'date_year_only end_range=-100',
                           :name => 'What year did <witness_name>witness</witness_name> moved to Nevada? /<spain/>¿En qué año se mudo <witness_name>testigo</witness_name> a Nevada?',
                           :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please select date /<spain/>Por favor seleccione la fecha' }

current_step = template.steps.create :step_number => step_number += 1,#49
                                     :title => 'Domestic violence /<spain/>Violencia domestica',
                                     :description => 'Are you or have been a victim of domestic violence by your spouse?
                                                      <br/><spain/>¿Es o ha sido víctima de violencia doméstica por su cónyuge?'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Have you ever had or currently have a TEMPORARY PROTECTIVE ORDER (TPO) against your spouse?
                                                            <br/><spain/>¿Ha tenido usted o actualmente tiene una orden de protección (TPO) contra su cónyuge?', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :toggle_option => 'Yes', :sub_toggle_id => toggle_id + 1
current_step.fields.create :field_type => 'string', :name => 'Case # /<spain/># De caso:', :toggle_id => toggle_id, :toggle_option => 'Yes'

toggle_id += 1
current_step.fields.create :field_type => 'text', :name => 'Would you like this information to be on your Complaint?
                                                            <br/><spain/>¿Quiere que esta información este en su demanda?', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :toggle_id => toggle_id, :toggle_option => 'Yes'

current_step = template.steps.create :step_number => step_number += 1,#50
                                     :title => 'Court cost and attorney’s fees /<spain/> Costos de corte y abogado',
                                     :description => 'Are you requesting your spouse to reimburse you for the fees?
                                                      <br/><spain/>¿Está usted solicitando que su cónyuge le reembolse los gastos'

current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No'

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => clark_nye.id.to_s, :render_if_field_value => 'Clark',#51
                                     :title => 'Other cases in Family court /<spain/>Otros casos en la corte de Familia',
                                     :description => "Do you or other party in this case (including any minor child) have any other current case(s) or past case(s) in the Family Court or Juvenile Court in <insert id=#{ clark_nye.id }/> County?
                                                      <br/><spain/>¿Ha tenido o tiene usted u la otra persona en este caso (incluyendo cualquier de sus menores) otros casos en la corte de familia en el Condado de <insert id=#{ clark_nye.id }/>?"

other_cases_field = current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => other_cases_field.id.to_s, :render_if_field_value => 'Yes',#52
                                     :title => 'Other cases in Family court /<spain/>Otros casos en la corte de Familia',
                                     :description => '** If you don\'t remember write as much as you remember.
                                                      <br/><spain/>** Si no recuerdas toda la información escriba lo que recuerde.'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Divorce /<spain/>Divorcio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show default_no', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount default_no review_show', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date review_show', :name => 'Approximate Date of last Order: /<spain/>Fecha aproximada de la última orden:', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Temporary Protective Order (TPO) /<spain/>Orden de Protección', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show default_no', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount default_no review_show', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date review_show', :name => 'Approximate Date of last Order: /<spain/>Fecha aproximada de la última orden:', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Custody or Child Support /<spain/>Custodia  o Manutención de menor', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show default_no', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount default_no review_show', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date review_show', :name => 'Approximate Date of last Order: /<spain/>Fecha aproximada de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                                    <option/>Daughter /<spain/>Hija
                                    <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                                    <option/>Daughter /<spain/>Hija
                                    <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Paternity /<spain/>Paternidad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show default_no', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount default_no review_show', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date review_show', :name => 'Approximate Date of last Order: /<spain/>Fecha aproximada de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                                    <option/>Daughter /<spain/>Hija
                                    <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                                    <option/>Daughter /<spain/>Hija
                                    <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Juvenile Court or abuse and neglect /<spain/>Corte juvenil o abuso y negligencia', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show default_no', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount default_no review_show', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date review_show', :name => 'Approximate Date of last Order: /<spain/>Fecha aproximada de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                                    <option/>Daughter /<spain/>Hija
                                    <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                                    <option/>Daughter /<spain/>Hija
                                    <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Guardianship /<spain/>Tutela', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show default_no', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount default_no review_show', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date review_show', :name => 'Approximate Date of last Order: /<spain/>Fecha aproximada de la última orden:', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Termination of Parental Rights /<spain/>Terminación de la patria potestad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text review_show default_no', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline rev_br', :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount default_no review_show', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date review_show', :name => 'Approximate Date of last Order: /<spain/>Fecha aproximada de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                                    <option/>Daughter /<spain/>Hija
                                    <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase', :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'string-upcase rev_inline', :name => 'Last Name /<spain/>Apellido:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo
                              <option/>Daughter /<spain/>Hija
                              <option/>Another /<spain/>Otro', :field_type => 'radio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'amount-left', :name => '', :toggle_id => toggle_id

#
# END OF ALIMONY
#

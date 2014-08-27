#
# Hints and tricks:
#
# <separate/>  -  for radio only
# postfix '-last' could be added to radio for extra <br/>
# <insert> is marker for :header_ids
# In name e.g.      english <spain/> spain <spain/> example
#

#NOTICE: name used in link_to_documents tempate AND in lib/pdf_documents/documents/pdf.rb
Template.where( :name => 'Complaint for Divorce /<spain/>Demanda de Divorcio').first.try :destroy
template = Template.create :name => 'Complaint for Divorce /<spain/>Demanda de Divorcio', :description => 'No description /<spain/>No hay descripción' if !template.present?

step_number = 0

current_step = template.steps.create :step_number => step_number += 1,#0
                                     :title => 'In what county are you going to file your case? /<spain/>¿En qué condado va a archivar su formulario?'

clark_nye = current_step.fields.create :name => 'Nye', :field_type => 'radio', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1,#1
                                     :title => 'Your information /<spain/>Su Información'

current_step.fields.create :name => 'Name /<spain/>Nombre: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter name /<spain/>Escriba el nombre' }, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase'
current_step.fields.create :name => 'Last Name /<spain/>Apellido: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter last name /<spain/>Escriba el apellido' }, :field_type => 'string-upcase'
current_step.fields.create :name => 'Date of Birth /<spain/>Fecha de nacimiento: *', :field_type => 'date', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date of birthday /<spain/>Por favor, ponga la fecha de nacimiento' }
current_step.fields.create :name => 'Social Security # /<spain/># Seguro Social: <spain/>e.g. XXX-XX-XXXX', :mandatory => { :value => /^([0-9]{3}\D*[0-9]{2}\D*[0-9]{4})?$/, :hint => 'Please enter a valid Social Security Number. /<spain/>Por favor, ponga un número de Seguro Social válido' }
current_step.fields.create :name => 'Mailing Address /<spain/>Dirección de casa o postal: *', :mandatory => { :value => /^[0-9a-zA-Z\-,.\/ #]+$/, :hint => 'Please enter a valid mailing address /<spain/>Por favor, ponga una dirección de casa o postal válida' }
toggle_id = 0
toggle_id += 1
current_step.fields.create :name => 'In the United States /<spain/>En los Estados Unidos
                                     <option/>Outside the United States /<spain/>Fuera de los Estados Unidos', :toggle_id => toggle_id, :field_type => 'radio', :mandatory => { :value => /^[a-zA-Z\s]+$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :name => 'City /<spain/>Ciudad: *',  :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'states', :name => 'State /<spain/>Estado: *', :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }

current_step.fields.create :name => 'City/Town/Province: /<spain/>Ciudad/Pueblo/Provincia: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a City/Town/Province /<spain/>Por favor, proporciona una Ciudad/Pueblo/Provincia' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Country /<spain/>País: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a country /<spain/>Por favor, proporciona el país' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Zip Code /<spain/>Código postal: * ', :mandatory => { :value => /^\w+$/, :hint => 'Please enter a valid zip code /<spain/>Por favor, ponga un código postal válido' }
current_step.fields.create :name => 'Phone number /<spain/>Número de teléfono: <spain/>e.g. (xxx) xxx-xxxx', :mandatory => { :value => /^([A-Za-z0-9\- ()]{2,20})?$/, :hint => 'Please enter a valid Phone Number /<spain/>Por favor, ponga un número de teléfono válido' }
current_step.fields.create :name => 'Email /<spain/>Correo Electrónico: *', :mandatory => { :value => /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})+$/, :hint => 'Please enter a valid email /<spain/>Por favor, ponga un correo electrónico válido' }
current_step.fields.create :name => 'I am /<spain/>Yo soy:', :field_type => 'label'
current_step.fields.create :name => 'Wife /<spain/>Esposa
                                     <option/>Husband /<spain/>Esposo', :field_type => 'radio', :mandatory => { :value => /^Wife|Husband/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :name => 'Since you are the person starting the divorce action, you will be referred as the PLAINTIFF.
                                     <br/><spain/>Ya que usted es la persona que inicia la acción de divorcio, usted será referido como el demandante (PLAINTIFF)', :field_type => 'text'


current_step = template.steps.create :step_number => step_number += 1,#2
                                     :title => 'Your Spouse\'s Information /<spain/>Información de su esposa(o)',
                                     :description => 'This person will be referred as the DEFENDANT<br/><spain/>Esta persona será referida como el demandado (DEFENDANT)'

current_step.fields.create :name => 'Name /<spain/>Nombre: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter name /<spain/>Escriba el nombre' }, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase'
current_step.fields.create :name => 'Last Name /<spain/>Apellido: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter last name /<spain/>Escriba el apellido' }, :field_type => 'string-upcase'
current_step.fields.create :name => 'Date of Birth /<spain/>Fecha de nacimiento: *', :field_type => 'date', :field_type => 'date', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date of birthday /<spain/>Por favor, ponga la fecha de nacimiento' }
current_step.fields.create :name => 'Social Security # /<spain/># Seguro Social: <spain/>e.g. XXX-XX-XXXX', :mandatory => { :value => /^([0-9]{3}\D*[0-9]{2}\D*[0-9]{4})?$/, :hint => 'Please enter a valid Social Security Number. /<spain/>Por favor, ponga un número de Seguro Social válido' }
current_step.fields.create :name => 'Mailing Address or last Known address /<spain/>Dirección postal o última dirección:', :mandatory => { :value => /^([0-9a-zA-Z\-,.\/ #]+)?$/, :hint => 'Please enter a valid mailing address /<spain/>Por favor, ponga una dirección de casa o postal válida' }
toggle_id = 0
toggle_id += 1
current_step.fields.create :name => 'In the United States /<spain/>En los Estados Unidos
                                     <option/>Outside the United States /<spain/>Fuera de los Estados Unidos', :toggle_id => toggle_id, :field_type => 'radio'
current_step.fields.create :name => 'City /<spain/>Ciudad: *',  :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a city /<spain/>Por favor, proporciona una ciudad' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'states', :name => 'State /<spain/>Estado: *', :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a state /<spain/>Por favor, proporciona un estado' }

current_step.fields.create :name => 'City/Town/Province: /<spain/>Ciudad/Pueblo/Provincia: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a City/Town/Province /<spain/>Por favor, proporciona una Ciudad/Pueblo/Provincia' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Country /<spain/>País: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage country /<spain/>Por favor, proporciona el país' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Zip Code /<spain/>Código postal: ', :mandatory => { :value => /^(\w+)?$/, :hint => 'Please enter a valid zip code /<spain/>Por favor, ponga un código postal válido' }
current_step.fields.create :name => 'Email /<spain/>Correo Electrónico:', :mandatory => { :value => /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4})?+$/, :hint => 'Please enter a valid email /<spain/>Por favor, ponga un correo electrónico válido' }
current_step.fields.create :name => 'Phone number /<spain/>Número de teléfono: <spain/>e.g. (xxx) xxx-xxxx', :mandatory => { :value => /^([A-Za-z0-9\- ()]{2,20})?$/, :hint => 'Please enter a valid Phone Number /<spain/>Por favor, ponga un número de teléfono válido' }


toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1,#3
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


current_step = template.steps.create :step_number => step_number += 1,#4
                                     :title => 'Nevada Residency /<spain/>Residente de Nevada',
                                     :description => 'The party filing for divorce must be a Nevada resident for at least six weeks before the filing date.<br/>
                                                      A resident witness will need to sign an affidavit stating your residency in Nevada (relatives are allowed).<br/>
                                                      <spain/>Si usted es la persona que está presentando el divorcio, debe ser residente de Nevada por lo menos 6 semanas antes de archivar la demanda de divorcio.<br/>
                                                      El testigo de residencia deberá firmar una declaración jurada indicando que usted es residente de Nevada (se permiten familiares).'

current_step.fields.create :field_type => 'checkbox', :name => 'I have lived in Nevada for over 6 weeks. /<spain/>Yo, he vivido en Nevada por más de 6 semanas.', :mandatory => { :value => /^1$/, :hint => 'You need to be a Nevada resident before you can file for a divorce /<spain/>Usted tiene que ser un residente de Nevada antes de poder solicitar el divorcio' }

current_step = template.steps.create :step_number => step_number += 1,#5
                                     :title => 'Pregnancy /<spain/>Embarazada',
                                     :description => 'To my knowledge wife /<spain/>A mi conocimiento la esposa'

current_step.fields.create :field_type => 'radio', :name => 'IS NOT currently pregnant /<spain/>NO ESTÁ embarazada en este momento.
                                                             <option/>IS currently pregnant /<spain/>ESTÁ embarazada en este momento.', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1,#6 and 7
                                     :title => 'Children /<spain/>Menores',
                                     :description => 'Are there children born or legally adopted of this marriage UNDER the age of 18?<br/><spain/>¿Hay menores de 18 años nacidos o adoptados legalmente de este matrimonio?'

toggle_id = 0
toggle_id += 1
children_field = current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'text', :name => 'Children must have resided in Nevada for a minimum of 6 months before the Nevada District Court will take jurisdiction over them.<br/>
                                                            Have the child(ren) lived in Nevada for over 6 months?<br/>
                                                            <spain/>Los menores deben haber vivido en Nevada por un mínimo de 6 meses antes  que la corte de Nevada tenga el poder judicial sobre ellos.<br/>
                                                            ¿Han vivido los menores en Nevada por más de 6 meses?', :toggle_id => toggle_id, :toggle_option => 'Yes'

children_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                                              <option/>No. Nevada Court does not have the legal right to set
                                                            custody at this time, BUT you can still get a divorce
                                                            without custody. However, you will need to address the children\'s health insurance and child\'s support issue.<br/><spain/>No. La corte de Nevada no tiene el poder para establecer
                                                            custodia en este momento, PERO usted todavía puede
                                                            divorciarse sin custodia. Sin embargo tiene que hacer decisiones sobre el seguro médico y la y la manutención de los menores.', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes',#8
                                     :title => 'Number of children /<spain/>Número de menores'

current_step.fields.create :field_type => 'text', :name => 'How many minor children were born or legally adopted during this marriage?
                                                            <br/><spain/>¿Cuántos  menores nacieron o fueron adoptados legalmente durante este matrimonio?'
children_amount_field = current_step.fields.create :field_type => 'amount', :mandatory => { :value => /^[1-9]{1}$/, :hint => 'Please enter correct value /<spain/>Por favor, introduzca el valor correcto' }


toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id,#9
                                     :title => '<child_count> Information /<spain/>Información <child_count_spain>'

child_name = current_step.fields.create :name => 'Name /<spain/>Nombre: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter name /<spain/>Escriba el nombre' }, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase'

child_last_name = current_step.fields.create :name => 'Last Name /<spain/>Apellido: *', :mandatory => { :value => /^[a-zA-Z\- ]+$/, :hint => 'Enter last name /<spain/>Escriba el apellido' }, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento: *', :field_type => 'date', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date of birthday /<spain/>Por favor, ponga la fecha de nacimiento' }

current_step.fields.create :name => 'Place of Birth /<spain/>Lugar de nacimiento:', :field_type => 'text'
current_step.fields.create :name => 'In the United States /<spain/>En los Estados Unidos
                                     <option/>Outside the United States /<spain/>Fuera de los Estados Unidos', :toggle_id => toggle_id, :field_type => 'radio', :mandatory => { :value => /^[a-zA-Z\s]+$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :name => 'City /<spain/>Ciudad: *',  :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage city /<spain/>Por favor, proporciona una ciudad donde se casaron' }, :field_type => 'string-capitalize'
current_step.fields.create :field_type => 'states', :name => 'State /<spain/>Estado: *', :toggle_id => toggle_id, :toggle_option => 'In the United States', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage state /<spain/>Por favor, proporciona un estado donde se casaron' }

current_step.fields.create :name => 'City/Town/Province: <spain/>Ciudad/Pueblo/Provincia: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage City/Town/Province /<spain/>Por favor, proporciona una Ciudad/Pueblo/Provincia donde se casaron' }, :field_type => 'string-capitalize'
current_step.fields.create :name => 'Country /<spain/>País: *', :toggle_id => toggle_id, :toggle_option => 'Outside', :mandatory => { :value => /\w+/, :hint => 'Provide a marriage country /<spain/>Por favor, proporciona el país donde se casaron' }, :field_type => 'string-capitalize'

current_step.fields.create :name => 'Social Security # /<spain/># Seguro Social: <spain/>e.g. XXX-XX-XXXX', :mandatory => { :value => /^([0-9]{3}\D*[0-9]{2}\D*[0-9]{4})?$/, :hint => 'Please enter a valid Social Security Number. /<spain/>Por favor, ponga un número de Seguro Social válido' }
current_step.fields.create :name => 'Son /<spain/>Hijo
                                     <option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes', #:amount_field_id => children_amount_field.id,#10
                                     :title => 'Legal Custody /<spain/>Custodia Legal',
                                     :description => 'Legal Custody: the right of the parents to make legal decision for <child_count> regarding education, health care, religion, etc. for the welfare of <child_count>.
                                                      Who will have legal custody of <child_count>?
                                                      <br/><spain/>Custodia legal: el derecho de los padres para tomar decisiones legales acerca de <child_count_spain> en cuanto a la educación, salud, religión, etc. para el bienestar del <child_count_spain>.<br/>
                                                      ¿Quién tendrá la custodia legal de <child_count_spain>?'

current_step.fields.create :field_type => 'radio', :name => 'BOTH Parents /<spain/>AMBOS padres
                                                             <option/>Only MOM /<spain/>Solo MAMÁ
                                                             <option/>Only DAD /<spain/>Solo PAPÁ', :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id,#11
                                     :title => 'Physical Custody /<spain/>Custodia Física',
                                     :description => 'Select  the type of custody you would like to have:
                                                      <br/><spain/>Seleccione el tipo de custodia que usted desea:'

current_step.fields.create :field_type => 'text', :name => '<insert> physical custody.<spain/><insert> custodia física.', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
current_step.fields.create :field_type => 'label', :name => 'PRIMARY PHYSICAL CUSTODY: when the child live with one parent for most of the time (more than 60%) and has limited visitation with the other parent. <br/><spain/>CUSTODIA FISICA PRIMARIA : uando el menor vive con un padre/madre más del 60% y el otro padre/madre tiene visitas.<spain/>'

current_step.fields.create :field_type => 'radio-sub', :name => 'With mom and visits with dad /<spain/>Con mamá y visitas con papá.
                                                                 <option/>With dad and visit  with mom /<spain/>Con papá y visitas con mamá.<spain/>
                                                                 <separate/>JOINT PHYSICAL CUSTODY: when the child live with both parent 50/50 or 60/40 of the time.<spain/><br/>Custodia FISICA COMPARTIDA: cuando el menor vive con ambos padres 50/50 o 60/40 del tiempo.
                                                                 <option/>Both Parents /<spain/>Ambos padres.<spain/>
                                                                 <separate/>SOLE PHYSICAL CUSTODY: when the child live with one parent.<spain/><br/>CUSTODIA FÍSICA ÚNICA : cuando el menor vive solamente con uno de los padres.
                                                                 <option/>Only with the mom /<spain/>Solo con mamá
                                                                 <option/>Only with the dad /<spain/>Solo con papá', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes',#11.5
                                     :title => 'Holiday /<spain/>Feriados',
                                     :description => 'Do you want to discuss holidays at this time?<spain/>¿Quieres hablar de horario festivo en este momento?'
toggle_id = 0
toggle_id += 1
children_holidays_now = current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step.fields.create :field_type => 'text', :name => 'Do you want all children to have the same holiday schedule?
                                                            <br/><spain/>¿Quiere que todos los menores tengan el mismo horario de vacaciones?', :toggle_id => toggle_id, :toggle_option => 'Yes'

same_schedule = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                                             <option/>No', :toggle_id => toggle_id, :toggle_option => 'Yes'



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_holidays_now.id, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, :amount_field_if => same_schedule.id, :amount_field_if_option => 'No',#12
                                     :title => 'Holiday /<spain/>Feriados',
                                     :description => 'Check all the holiday that apply for your <child_count>:<br/><spain/>Marque todos los feriados que aplican para su <child_count_spain>:'

current_step.fields.create :field_type => 'text', :name => 'Holidays schedule for <insert><spain/>Holidays schedule para <insert>', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'New Year’s Eve from /<spain/>Víspera de año nuevo desde', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'New Year’s Day /<spain/>Año Nuevo', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Martin Luther King, Jr. Day /<spain/>Día  de Martin Luther King, Jr.', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'President’s day /<spain/>Día de los Presidentes', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Passover', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Easter /<spain/>Pascua', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Memorial Day', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

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





current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_holidays_now.id, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id, :amount_field_if => same_schedule.id, :amount_field_if_option => 'No',#13
                                     :title => 'More Holiday /<spain/>Más Feriados',
                                     :description => 'Check all the holiday that apply for your <child_count>:<br/>
                                                      <spain/>Marque todos los feriados que aplican para su <child_count_spain>:'

current_step.fields.create :field_type => 'text', :name => 'More Holidays schedule for <insert><spain/>Más Holidays schedule para <insert>', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => '4th of July /<spain/>4 de Julio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Labor Day /<spain/>Día del trabajador', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Rosh Hashanah /<spain/>Rosh Hashanah', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Yom Kippur', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Nevada Day /<spain/>Día de Nevada', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Halloween', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Veteran’s Day /<spain/>Día de los Veteranos', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Thanksgiving Day /<spain/>Día de Acción de Gracias', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Christmas Eve /<spain/>Víspera de noche de Navidad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Christmas /<spain/>Navidad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

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
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Chinese  New Year’s /<spain/>Año Nuevo Chino', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Chanukkah', :toggle_id => toggle_id
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Spring Break /<spain/>Vacaciones de primavera', :toggle_id => toggle_id
current_step.fields.create :field_type => 'radio-last', :name => 'all /<spain/>Todo la vacacion
                                                                  <option/>portion /<spain/>porcion de la vacacion con', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                             <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>odd years /<spain/>año impares
                                                             <option/>even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Winter Break /<spain/>Vacaciones de invierno', :toggle_id => toggle_id
current_step.fields.create :field_type => 'radio-last', :name => 'all /<spain/>Todo la vacacion
                                                                  <option/>portion /<spain/>porcion de la vacacion con', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                             <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>odd years /<spain/>año impares
                                                             <option/>even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Summer Break /<spain/>Vacaciones de verano', :toggle_id => toggle_id
current_step.fields.create :field_type => 'radio-last', :name => 'all /<spain/>Todo la vacacion
                                                                  <option/>portion /<spain/>porcion de la vacacion con', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                             <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>odd years /<spain/>año impares
                                                             <option/>even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other Holiday /<spain/>Otro Feriado', :toggle_id => toggle_id
current_step.fields.create :name => 'Holiday Name /<spain/>Holiday Nombre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter holiday name /<spain/>Por favor, ponga el feriado' }
current_step.fields.create :field_type => 'date', :toggle_id => toggle_id, :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please enter a date /<spain/>Por favor, ponga la fecha' }
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'from /<spain/>desde'
current_step.fields.create :field_type => 'time', :toggle_id => toggle_id, :name => 'to /<spain/>hasta'
current_step.fields.create :field_type => 'radio-last', :name => 'Mom /<spain/>Madre
                                                                  <option/>Dad /<spain/>Padre', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'every year /<spain/>todos los años
                                                             <option/>every odd years /<spain/>año impares
                                                             <option/>every even years /<spain/>año pares', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

#                 END OF HOLIDAY

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes',#14
                                     :title => '<child_count> Health Insurance /<spain/>Seguro Médico <child_count_spain> ',
                                     :description => 'Who will be responsible for maintaining health and dental insurance for <child_count>? /
                                                      <spain/>¿Quién será responsable de mantener el seguro médico y dental para <child_count_spain>?'

current_step.fields.create :field_type => 'radio', :name => 'Mom /<spain/>Mamá
                                                             <option/>Dad /<spain/>Papá
                                                             <option/>Both Parents /<spain/>Ambos Padres', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes',#15
                                     :title => '<child_count> Support /<spain/>Manutención <child_count_spain>'

current_step.fields.create :field_type => 'radio', :name => 'No <child_count> support /<spain/>No habrá manutención <child_count_spain>
                                                             <option/>Dad will pay $ /<spain/>El papá pagara $
                                                             <option/>Mom will pay $ /<spain/>La mamá pagara $', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'amount', :name => 'per month as <child_count> support /<spain/>mensual de manutención para <child_count_spain>', :toggle_id => toggle_id, :toggle_option => 'will', :mandatory => { :value => /^[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes',#16
                                     :title => 'Wage withholding /<spain/>Retención de Sueldo'


current_step.fields.create :field_type => 'text', :name => 'Are you requesting wage withholding to collect <child_count> support?
                                                            <br/><spain/>¿Está pidiendo retención de salario para cobrar la manutención de <child_count_spain>?'

current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                             <option/>No', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes',#17
                                     :title => '<child_count> Support Arrears /<spain/>Manutención <child_count_spain> Retroactiva'

current_step.fields.create :field_type => 'text', :name => 'You can request up to 4 years of back <child_count> support. <br/><spain/>Puede pedir hasta 4 años atrasados de manutención de <child_count_spain>.'

current_step.fields.create :field_type => 'text', :name => 'Are you requesting <child_count> support ARREARS? <br/><spain/>¿Está solicitando manutención ATRASADA de <child_count_spain>?'
current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                             <option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'date_without_day', :name => 'I want back <child_count> support starting /<spain/>Quiero la manutención de <child_count_spain> a partir', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^[0-9]{1,2}\/[0-9]{4}$/, :hint => 'Please select date /<spain/>Por favor seleccione la fecha' }
current_step.fields.create :field_type => 'text', :name => 'The OTHER parent has paid /<spain/>del otro padre ha pagado', :toggle_id => toggle_id, :toggle_option => 'Yes'
current_step.fields.create :field_type => 'amount', :name => 'since separation. /<spain/>ya la separación.', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^(\$)?[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto' }

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => children_field.id, :render_if_field_value => 'Yes', :amount_field_id => children_amount_field.id,#18
                                     :title => '<child_count> Tax Exemption /<spain/>En los Impuestos <child_count_spain>'

current_step.fields.create :field_type => 'text', :name => 'Who will claim <insert> as dependent on tax returns?<br/><spain/>¿Quién reclamará <insert> como dependiente en los impuestos?', :header_ids => "#{ child_name.id }/#{ child_last_name.id }"
current_step.fields.create :field_type => 'radio', :name => 'Mom every year /<spain/>Mamá todos los años
                                                             <option/>Dad every year /<spain/>Papá todos los años
                                                             <option/>Dad and Mom alternating years /<spain/>Mamá y Papá años por medio', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'only_year', :name => 'Mom will start claiming the child from /<spain/>La mamá comenzara a reclamar el menor desde:', :toggle_id => toggle_id, :toggle_option => 'Dad and Mom', :mandatory => { :value => /\w+/, :hint => 'Please select date /<spain/>Seleccione uno, por favor' }

toggle_id = 0
toggle_id += 1
current_step = template.steps.create :step_number => step_number += 1,#19
                                     :title => 'Pet /<spain/>Mascota',
                                     :description => 'Do you have pets that you would like the court to give you custody of?
                                                      <spain/>¿Va a pedir la custodia de sus mascotas en la corte?'

pet_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                                         <option/>No', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

pet_amount_field = current_step.fields.create :field_type => 'amount', :name => 'How many: /<spain/>Cuántos:', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => pet_field.id, :render_if_field_value => 'Yes', :amount_field_id => pet_amount_field.id,#20
                                     :title => 'Pet Custody /<spain/>Custodia de Mascota'

current_step.fields.create :name => 'Name of your Pet: *
                                     <spain/>Nombre de su mascota:*', :mandatory => { :value => /\w+/, :hint => 'Please enter a valid pet name /<spain/>Por favor, ponga un nombre válido de mascota' }

current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Se QUEDARA con la esposa
                                                             <option/>Husband will keep /<spain/>Se QUEDARA con el esposo
                                                             <option/>Both Equally /<spain/>AMBOS TENDREMOS custodia ', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



#
# PROPERTY DIVISION
#


current_step = template.steps.create :step_number => step_number += 1,#21
                                     :title => 'Property /<spain/>Bienes',
                                     :description => 'Nevada is a community property state, regardless of your immigration status. This means that the law presumes that all property (bank account, 401K, house, military pension, car, furniture, jewelry, etc.) acquired or incurred during the marriage is community property, and belongs equally to both parties, with the exception of separate property.
                                                      <br/><spain/>Nevada es un estado de propiedad comunitaria, no importa su estatus migratorio. Esto significa que la ley presupone que todas las propiedades (cuenta bancaria, 401 k, casa, pensión militar, carro, muebles, joyería, etc.) adquiridas o compradas durante el matrimonio son bienes comunitarios y pertenece igualmente a ambas partes, con la excepción de la propiedad individual.'

current_step.fields.create :field_type => 'text', :name => 'Do you have community property to divide?
                                                            <br/><spain/>¿Tienen propiedad en común que dividir?'

property_division_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No<option/>No, we already divided them /<spain/>No ya las dividimos', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

#22 deleted

toggle_id = 1
current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id, :render_if_field_value => 'Yes',#23
                                     :title => 'Property Division: Home/Mobile home/land/Business /<spain/>División de Propiedad: Casa/lote/Negocio',
                                     :description => 'What did you buy during the marriage and need to be divided?
                                                      <br/><spain/>¿Qué compraron durante el matrimonio se tiene que dividir?'

current_step.fields.create :field_type => 'checkbox', :name => 'Home /<spain/>Casa', :toggle_id => toggle_id, :sort_index => 'a1'
house_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Home/Casa<beginText/>Address /<spain/>Dirección:', :amount_field_id => house_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }
current_step.fields.create :field_type => 'radio-last', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :amount_field_id => house_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Empty land /<spain/>Lote-Tierra', :toggle_id => toggle_id, :sort_index => 'b1'
land_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Empty land/Lote-Tierra<beginText/>Address /<spain/>Dirección:', :amount_field_id => land_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }
current_step.fields.create :field_type => 'radio-last', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :amount_field_id => land_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Business /<spain/>Negocio', :toggle_id => toggle_id, :sort_index => 'c1'
business_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Business/Negocio<beginText/>Name of the business /<spain/>Nombre del negocio:', :amount_field_id => business_number_field.id, :raw_question => false, :toggle_id => toggle_id
current_step.fields.create :name => 'Address /<spain/>Dirección:', :amount_field_id => business_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }
current_step.fields.create :field_type => 'radio-last', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :amount_field_id => business_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id, :render_if_field_value => 'Yes',#24
                                     :title => 'Property Division: Vehicles /<spain/>División de Propiedades: Vehículos',
                                     :description => 'Was there a car, motorcycle, rv, boat, trailer purchased during the marriage?
                                                      <br/><spain/>¿Compraron carro, moto, rv, barco, remolque durante el matrimonio?'

property_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }






current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_field.id, :render_if_field_value => 'Yes',#25
                                     :title => 'Property Division: Vehicles /<spain/>División de Propiedades: Vehículos'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Car /<spain/>Carro', :toggle_id => toggle_id, :sort_index => 'a1'
car_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Car/Carro<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :toggle_id => toggle_id, :amount_field_id => car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Motorcycle /<spain/>Motocicleta', :toggle_id => toggle_id, :sort_index => 'b1'
motorcycle_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Motorcycle/Motocicleta<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :toggle_id => toggle_id, :amount_field_id => motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'RV', :toggle_id => toggle_id, :sort_index => 'c1'
rv_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'RV/RV<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :toggle_id => toggle_id, :amount_field_id => rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Boat /<spain/>Barco', :toggle_id => toggle_id, :sort_index => 'd1'
boat_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'd2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Boat/Barco<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :toggle_id => toggle_id, :amount_field_id => boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Trailer /<spain/>Remolque', :toggle_id => toggle_id, :sort_index => 'e1'
trailer_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'e2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Trailer/Remolque<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => trailer_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :toggle_id => toggle_id, :amount_field_id => trailer_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other /<spain/>Otro', :toggle_id => toggle_id, :sort_index => 'f1'
other_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'f2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Other/Otro<beginText/>Write year, model and VIN # if you have it /<spain/>Escriba el año, modelo y VIN # si lo tiene', :toggle_id => toggle_id, :amount_field_id => other_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter year, model and VIN /<spain/>Por favor introduce el año, modelo y VIN' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep it /<spain/>Esposa se quedara con ella
                                                             <option/>Sell it /<spain/>Vender
                                                             <option/>Husband will keep it /<spain/>Mi esposo se quedara con ella', :toggle_id => toggle_id, :amount_field_id => other_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }







current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id, :render_if_field_value => 'Yes',#26
                                     :title => 'Property Division: Pension Benefit /<spain/>División de Beneficios de Pensión',
                                     :description => 'Is there a pension benefit, retirement fund, 401K, 403B, military pension, other retirement benefits obtain during the marriage?
                                                      <br/><spain/>¿Hay beneficio de Pensión, 401 k, 403B, pensión militar, otros beneficios de jubilación durante a matrimonio?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /^Yes|No$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sort_index => 'a1'
plan_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Plan/Plan<beginText/>Name of the plan: /<spain/>Nombre del plan de beneficios:', :toggle_id => toggle_id, :amount_field_id => plan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter name of the plan /<spain/>Por favor ingrese el nombre del plan' }
current_step.fields.create :field_type => 'radio', :name => 'I will keep /<spain/>Para Mi
                                                             <option/>I want a portion /<spain/>Quiero una porción
                                                             <option/>My spouse will keep it /<spain/>Para mi esposa(o)', :toggle_id => toggle_id, :amount_field_id => plan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id, :render_if_field_value => 'Yes',#27
                                     :title => 'Property Division: Bank and Investment Account
                                                <br/><spain/>División de Cuentas Bancarias e Inversiones',
                                     :description => 'Is there bank accounts, investment account or any other financial account obtain during the marriage?
                                                      <br/><spain/>¿Hay cuentas bancarias, de inversiones, u otro tipo de cuenta financiera obtenida  durante el matrimonio?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /^Yes|No$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }, :sort_index => 'a1'
bank_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Account/Cuenta<beginText/>Name of the account /<spain/>Nombre de la cuenta', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter name of the account /<spain/>Por favor introduce el nombre de la cuenta' }
current_step.fields.create :name => 'approximate amount in it /<spain/>la cantidad aproximada', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter approximate amount in it /<spain/>Por favor, ingrese el monto aproximado en ella' }
current_step.fields.create :name => 'last 4# (if possible) /<spain/>los últimos 4# (si es posible):', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter last 4# /<spain/>Por favor introduce el pasado 4 #' }
current_step.fields.create :field_type => 'radio', :name => 'I will keep /<spain/>Para Mi
                                                             <option/>I want a portion /<spain/>Quiero una porción
                                                             <option/>My spouse will keep it /<spain/>Para mi esposa(o)', :toggle_id => toggle_id, :amount_field_id => bank_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => property_division_field.id, :render_if_field_value => 'Yes',#28
                                     :title => 'Property Division: Other /<spain/>División de Bienes: Otro',
                                     :description => 'Is there anything else bought during the marriage that you want to keep?
                                                      <br/><spain/>¿Compro algo más durante el matrimonio que desea quedarse?'


other_property_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí<option/>No', :mandatory => { :value => /^Yes|No$/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => other_property_field.id, :render_if_field_value => 'Yes',#29
                                     :title => 'Property Division: Other /<spain/>División de Bienes: Otro',
                                     :description => 'Check all that apply and you want to keep: /<spain/>Marque todas las cosas que le gustaría mantener:'

current_step.fields.create :field_type => 'checkbox', :name => 'Household item /<spain/>cosas de la casa'
current_step.fields.create :field_type => 'checkbox', :name => 'Jewelry /<spain/>Joyas'
current_step.fields.create :field_type => 'checkbox', :name => 'Collections /<spain/>Colecciones'
current_step.fields.create :field_type => 'checkbox', :name => 'Furniture /<spain/>Muebles'
current_step.fields.create :field_type => 'checkbox', :name => 'Everything currently in my possession /<spain/>Todas las cosas en mi poder en este momento'






#
# END OF PROPERTY DIVISION
#




#
# DEBTS
#


current_step = template.steps.create :step_number => step_number += 1,#30
                                     :title => 'Debts /<spain/>Deudas',
                                     :description => 'Do you have community debts to divide?
                                                      <br/><spain/>¿Tienen deudas en común que dividir?'

current_step.fields.create :field_type => 'text', :name => 'Nevada is a community property state, regardless of your immigration status. This means that the law presumes that all debts (credit cards, loans, mortgage, taxes, hospital bills, etc.) acquired or incurred during the marriage is community debts, and belongs equally to both parties, with the exception of separate debt.
                                                            <br/><spain/>Nevada es un estado de propiedad comunitaria, no importa su estatus migratorio. Esto significa que la ley presupone que todas las deudas (tarjetas de crédito, préstamos, impuestos, cuenta de hospital, etc.) adquiridas o incurridas durante el matrimonio son responsabilidad de ambas partes y pertenecen igualmente a los dos, con la excepción de deudas individuales.'

debts_division_field = current_step.fields.create :field_type => 'radio', :name => 'Yes /<spain/>Sí
                                                                                    <option/>No<option/>No, we already divided them /<spain/>No ya las dividimos', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id, :render_if_field_value => 'Yes',#31
                                     :title => 'Debts Division: Mortgages /<spain/>División de Deudas: Hipotecas',
                                     :description => 'Do you have any of these loans to divide?
                                                      <br/><spain/>¿Tienen algunas de estos préstamos que dividir?'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Home /<spain/>Casa', :toggle_id => toggle_id, :sort_index => 'a1'
debt_house_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Home/Casa<beginText/>Address /<spain/>Dirección:', :amount_field_id => debt_house_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }
current_step.fields.create :name => 'Bank and amount owe /<spain/>Banco y cantidad que se debe:', :toggle_id => toggle_id, :amount_field_id => debt_house_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter bank and amount owe /<spain/>Por favor, introduzca banco y la cantidad deben' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                                                    <option/>Husband will keep /<spain/>Esposo va a pagar
                                                                                    <option/>Pay with sell of home /<spain/>Pagar con venta de casa', :toggle_id => toggle_id, :amount_field_id => debt_house_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Empty land /<spain/>Lote-Tierra', :toggle_id => toggle_id, :sort_index => 'b1'
debt_land_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Empty land/Lote-Tierra<beginText/>Address /<spain/>Dirección:', :amount_field_id => debt_land_number_field.id, :raw_question => false, :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please enter address /<spain/>Por favor, ponga una dirección' }
current_step.fields.create :name => 'Bank and amount owe /<spain/>Banco y cantidad que se debe:', :toggle_id => toggle_id, :amount_field_id => debt_land_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter bank and amount owe /<spain/>Por favor, introduzca banco y la cantidad deben' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                                                    <option/>Husband will keep /<spain/>Esposo va a pagar
                                                                                    <option/>Pay with sell of home /<spain/>Pagar con venta de casa', :toggle_id => toggle_id, :amount_field_id => debt_land_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id, :render_if_field_value => 'Yes',#32
                                     :title => 'Debt Division: Credit Cards, hospital or medical bills
                                                <br/><spain/>División de Deuda: Tarjeta de Crédito, Cuenta de hospital o doctor:',
                                     :description => 'Are there any credit cards, hospital or medical bills to divide?
                                                      <br/><spain/>¿Tiene tarjetas de créditos, cuenta de hospital o doctores que dividir?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Credit Cards /<spain/>Tarjetas de crédito', :sort_index => 'a1', :toggle_id => toggle_id
credits_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Credit Cards/Tarjetas de crédito<beginText/>Card, amount, last 4# (if possible): (example Visa, $1000, #1234) /<spain/>Tarjeta, cantidad, últimos 4#: (ejemplo Visa, $ 1000, #1234)', :toggle_id => toggle_id, :amount_field_id => credits_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Card, amount, last 4# /<spain/>Por favor introduce la tarjeta, la cantidad, el pasado 4 #' }

current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                            <option/>Divide /<spain/>Dividir
                                                            <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => credits_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Hospital bills /<spain/>Las facturas del hospital', :toggle_id => toggle_id, :sort_index => 'b1'
hospital_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Hospital bills/Las facturas del hospital<beginText/>Hospital bill $ (enter amount) /<spain/>Cuenta de hospital', :toggle_id => toggle_id, :amount_field_id => hospital_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Hospital bill /<spain/>Por favor introduce factura del hospital' }

current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                            <option/>Divide /<spain/>Dividir
                                                            <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => hospital_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Doctor bills /<spain/>Facturas del médico', :toggle_id => toggle_id, :sort_index => 'c1'
doctor_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Doctor bills/Facturas del médico<beginText/>Doctor bill $ (enter amount) /<spain/>Cuenta de doctor', :toggle_id => toggle_id, :amount_field_id => doctor_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Doctor bill /<spain/>Por favor introduce proyecto de ley médico' }

current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                            <option/>Divide /<spain/>Dividir
                                                            <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => doctor_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id, :render_if_field_value => 'Yes',#33
                                     :title => 'Debt Division: Car Loan /<spain/>División de Deudas: Préstamo de Carro',
                                     :description => 'Is there any car, rv, boat, motorcycle loan to divide?
                                                      <br/><spain/>¿Tiene algún préstamo de carro, rv, barco, moto que dividir?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Car /<spain/>Carro', :sort_index => 'a1', :toggle_id => toggle_id
debt_car_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Car/Carro<beginText/>Car Amount owe: (example Ford about $10,000) /<spain/>Carro y cantidad que se debe: (ejemplo Ford $10,000)', :toggle_id => toggle_id, :amount_field_id => debt_car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter car amount owe /<spain/>Por favor, ingrese el monto coche debo' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_car_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'RV', :sort_index => 'b1', :toggle_id => toggle_id
debt_rv_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'RV/RV<beginText/>RV Amount owe: (example about $10,000) /<spain/>RV y cantidad que se debe: (ejemplo  $10,000)', :toggle_id => toggle_id, :amount_field_id => debt_rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter rv amount owe /<spain/>Por favor, ingrese el monto rv debo' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_rv_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Boat /<spain/>Barco', :sort_index => 'c1', :toggle_id => toggle_id
debt_boat_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Boat/Barco<beginText/>Boat Amount owe: (example about $10,000) /<spain/>Barco cantidad que se debe: (ejemplo 10,000)', :toggle_id => toggle_id, :amount_field_id => debt_boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter boat amount owe /<spain/>Por favor, ingrese el monto barco debo' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_boat_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Motorcycle /<spain/>Moto', :sort_index => 'd1', :toggle_id => toggle_id
debt_motorcycle_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'd2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Motorcycle/Moto<beginText/>Motorcycle Amount owe: (example Honda about $10,000) /<spain/>Moto y cantidad que se debe: (ejemplo Honda $10,000)', :toggle_id => toggle_id, :amount_field_id => debt_motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter motorcycle amount owe /<spain/>Por favor, ingrese el monto de la motocicleta le debe' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => debt_motorcycle_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id, :render_if_field_value => 'Yes',#34
                                     :title => 'Debt Division: Student loans, IRS, payday loans, other /<spain/>División de Deuda: Préstamo estudiantil, IRS, otra deuda',
                                     :description => 'Is there any student loan, IRS, payday loans, other debt to divide?
                                                      <br/><spain/>¿Tiene algún préstamo estudiantil, IRS, otra deuda para dividir?'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Student loan /<spain/>Préstamo estudiantil', :sort_index => 'a1', :toggle_id => toggle_id
student_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Student loan/Préstamo estudiantil<beginText/>Student loan, amount owe: (example $10,000) /<spain/>Préstamo estudiantil  deuda: (ejemplo $10,000)', :toggle_id => toggle_id, :amount_field_id => student_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter student loan, amount owe /<spain/>Por favor introduce préstamo estudiantil, cantidad debo' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => student_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'IRS /<spain/>Impuestos', :sort_index => 'b1', :toggle_id => toggle_id
irs_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'b2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'IRS/Impuestos<beginText/>IRS amount owe: (example $10,000) /<spain/>Impuestos deuda: (ejemplo $10,000)', :toggle_id => toggle_id, :amount_field_id => irs_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter IRS amount owe /<spain/>Por favor, ingrese el monto Impuestos le debe' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => irs_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Payday loan /<spain/>Préstamo de Día de pago', :sort_index => 'c1', :toggle_id => toggle_id
payday_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'c2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Payday loan/Préstamo de Día de pago<beginText/>Payday loan, amount owe: (example $1,000) /<spain/>Préstamo de Día de pago deuda: (ejemplo $1,000)', :toggle_id => toggle_id, :amount_field_id => payday_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter payday loan, amount owe /<spain/>Por favor introduce préstamo de día de pago, cantidad debo' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => payday_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other loan /<spain/>Otro préstamo', :sort_index => 'd1', :toggle_id => toggle_id
other_loan_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'd2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Other loan/Otro préstamo<beginText/>Loan amount owe: (example $2,000) /<spain/>Préstamo deuda: (ejemplo $2,000)', :toggle_id => toggle_id, :amount_field_id => other_loan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter Loan amount owe /<spain/>Por favor, ingrese el monto del préstamo debo' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => other_loan_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => debts_division_field.id, :render_if_field_value => 'Yes',#35
                                     :title => 'Debt Division: Other /<spain/>División de Deuda: Otro',
                                     :description => 'Is there any other debt incurred during the marriage that you want to divide?
                                                      <br/><spain/>¿Hay otra deuda que fue adquirida durante el matrimonio que desea dividir?'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Other Debt Division /<spain/>Otra división de la deuda', :sort_index => 'a1', :toggle_id => toggle_id
other_debt_number_field = current_step.fields.create :name => 'How Many /<spain/>Cuantos:', :field_type => 'sub_amount', :toggle_id => toggle_id, :toggle_option => 'Yes', :sort_index => 'a2', :mandatory => { :value => /^[1-9]$/, :hint => 'Please enter count or press button "Description" /<spain/>Por favor introduce el recuento o el botón "Descripción"' }
current_step.fields.create :name => 'Other Debt Division/Otra división de la deuda<beginText/>(example: Parents $ 300) /<spain/>(ejemplo: Los padres $ 300)', :toggle_id => toggle_id, :amount_field_id => other_debt_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please enter value /<spain/>Por favor introduce el valor' }
current_step.fields.create :field_type => 'radio', :name => 'Wife will keep /<spain/>Esposa va a pagar
                                                             <option/>Divide /<spain/>Dividir
                                                             <option/>Husband will keep /<spain/>Esposo va a pagar', :toggle_id => toggle_id, :amount_field_id => other_debt_number_field.id, :raw_question => false, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



#
# END OF DEBTS
#




#
# ALIMONY
#


current_step = template.steps.create :step_number => step_number += 1,#36
                                     :title => 'Spousal support or Alimony /<spain/>Manutención de Esposa(o)',
                                     :description => 'There is no precise formula for awarding spousal support/alimony; it is decided on a case by case basis.
 <br/><spain/>No hay ninguna fórmula precisa para determinar la manutención de esposo(a); se decide caso por caso.'


toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'radio', :name => 'Wife WILL PAY spousal support $ /<spain/>Esposa PAGARA manutención en la cantidad de $ por mes.
                                                             <option/>Husband WILL PAY spousal support $ /<spain/>Esposo PAGARA manutención en la cantidad de $ por mes.', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :field_type => 'amount', :name => 'Enter monthly amount /<spain/>Ingrese el monto mensual', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^[0-9]+$/, :hint => 'Please enter amount /<spain/>Por favor, ingrese el monto' }
current_step.fields.create :field_type => 'amount', :name => 'For how long ? (enter number) /<spain/>¿Por cuánto tiempo? (ponga en número)', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /^[0-9,]+$/, :hint => 'Please enter a number /<spain/>Por favor, introduzca un número' }

current_step.fields.create :field_type => 'radio', :name => 'Months /<spain/>Meses
                                                             <option/>Year(s) (example 1 year) /<spain/>Año(s)  (ejemplo 1 año)', :toggle_id => toggle_id, :toggle_option => 'Yes', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }


current_step = template.steps.create :step_number => step_number += 1,#37
                                     :title => 'Wife’s Name /<spain/>Cambio de Apellido'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'radio', :name => 'Wife never change her name /<spain/>La esposa nunca se cambió el apellido
                                                             <option/>Wife will keep married name /<spain/>La esposa se va a quedar con el apellido de casada
                                                             <option/>Wife will return to her maiden name /<spain/>La esposa volverá a su apellido de soltera que es', :toggle_id => toggle_id, :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }

current_step.fields.create :toggle_id => toggle_id, :name => 'Wife\'s maiden name /<spain/>Apellido de soltera', :toggle_option => 'Wife will return', :mandatory => { :value => /\w+/, :hint => 'Please enter /<spain/>Seleccione, por favor' }



current_step = template.steps.create :step_number => step_number += 1,#38
                                     :title => 'Reason for divorce  /<spain/>Razón por el divorcio',
                                     :description => 'Nevada is a "no fault" divorce state.  This means the person seeking the divorce does not have to prove in court that she or he is entitled to a divorce.
                                                      <br/><spain/>Nevada es un estado de divorcio "sin culpa".  Esto significa que la persona que busca el divorcio no tiene que probar en la corte que él o ella tiene el derecho a divorciarse.'

current_step.fields.create :field_type => 'radio', :name => 'I no longer want to be married /<spain/>Ya no quiero seguir casado porque no nos entendemos
                                                             <option/>I no longer want to be married and have lived separated and apart for over 1 year /<spain/>Ya no quiero seguir casada y hemos vivido separados desde hace más de 1 año', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }



current_step = template.steps.create :step_number => step_number += 1,#39
                                     :title => 'Other cases in Family court /<spain/>Otros casos en la corte de Familia',
                                     :description => "Do you or other party in this case (including any minor child) have any other current case(s) or past case(s) in the Family Court or Juvenile Court in <insert id=#{ clark_nye.id }/> County?
                                                      <br/><spain/>¿Ha tenido o tiene usted u la otra persona en este caso (incluyendo cualquier de sus menores) otros casos en la corte de familia en el Condado de <insert id=#{ clark_nye.id }/>?"

other_cases_field = current_step.fields.create :field_type => 'radio', :name => 'No<option/>Yes /<spain/>Sí', :mandatory => { :value => /\w+/, :hint => 'Please select one /<spain/>Seleccione uno, por favor' }




current_step = template.steps.create :step_number => step_number += 1, :render_if_field_id => other_cases_field.id, :render_if_field_value => 'Yes',#40
                                     :title => 'Other cases in Family court /<spain/>Otros casos en la corte de Familia',
                                     :description => '** If you don\'t remember write as much as you remember.
                                                      <br/><spain/>** Si no recuerdas toda la información escriba lo que recuerde.'

toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Divorce /<spain/>Divorcio', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'text', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'amount', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of last Order: /<spain/>Día de la última orden:', :toggle_id => toggle_id


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Temporary Protective Order (TPO) /<spain/>Orden de Protección', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'text', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'amount', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of last Order: /<spain/>Día de la última orden:', :toggle_id => toggle_id


toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Custody or Child Support /<spain/>Custodia  o Manutención de menor', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'text', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'amount', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of last Order: /<spain/>Día de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Paternity /<spain/>Paternidad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'text', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'amount', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of last Order: /<spain/>Día de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Juvenile Court or abuse and neglect /<spain/>Corte juvenil o abuso y negligencia', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'text', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'amount', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of last Order: /<spain/>Día de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id



toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Guardianship /<spain/>Tutela', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'text', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'amount', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of last Order: /<spain/>Día de la última orden:', :toggle_id => toggle_id

toggle_id += 1
current_step.fields.create :field_type => 'checkbox', :name => 'Termination of Parental Rights /<spain/>Terminación de la patria potestad', :toggle_id => toggle_id
current_step.fields.create :field_type => 'text', :name => 'Person involved: /<spain/>Persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'text', :name => 'Other person involved: /<spain/>La otra persona involucrada:', :toggle_id => toggle_id
current_step.fields.create :name => 'Last name /<spain/>Apellido', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'First name /<spain/>Nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :name => 'Middle name /<spain/>Segundo nombre', :toggle_id => toggle_id, :field_type => 'string-upcase'
current_step.fields.create :field_type => 'amount', :name => 'Case # /<spain/># de caso:', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of last Order: /<spain/>Día de la última orden:', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Complete only if other children were involved - not the ones already mentioned <br/><spain/>Completar sólo si otros niños estuvieron involucrados - no a los ya mencionan.', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Child involved: /<spain/>Menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id

current_step.fields.create :field_type => 'text', :name => 'Other child involved: /<spain/>El otro menor involucrado:', :toggle_id => toggle_id
current_step.fields.create :name => 'Name /<spain/>Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Middle Initial /<spain/>Inicial del Segundo Nombre:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :name => 'Last Name /<spain/>Apellido:', :field_type => 'string-upcase', :toggle_id => toggle_id
current_step.fields.create :field_type => 'date', :name => 'Date of Birth /<spain/>Fecha de nacimiento:', :field_type => 'date', :toggle_id => toggle_id
current_step.fields.create :name => 'Son /<spain/>Hijo<option/>Daughter /<spain/>Hija', :field_type => 'radio', :toggle_id => toggle_id


#
# END OF ALIMONY
#

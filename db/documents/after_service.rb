Template.where( :name => 'After Service /<spain/>Después de servicio').first.try :destroy
template = Template.create :name => 'After Service /<spain/>Después de servicio', :description => 'No description /<spain/>No hay descripción' if !template.present?

step_number = 0

current_step = template.steps.create :step_number => step_number += 1,#1
                                     :title => 'ENTER INFORMATION /<spain/>ESCRIBA LA INFORMACIÓN'
toggle_id = 0
toggle_id += 1
current_step.fields.create :field_type => 'text', :name => 'Date <defendant_full_name> was served with the documents /<spain/>Fecha cuando <defendant_full_name> recibio los documentos *'
current_step.fields.create :name => '', :field_type => 'date_future_end_range=10'
current_step.fields.create :field_type => 'text', :name => 'Date Affidavit of Service was filed with the court /<spain/>Fecha cuando la declaracion de entrega de documentos fue archiva en la corte *'
current_step.fields.create :name => '', :field_type => 'date_future_end_range=10'

current_step = template.steps.create :step_number => step_number += 1,#2
                                     :title => 'FINISH /<spain/>ACABADO'
current_step.fields.create :field_type => 'text', :name => 'Congratulation you have finished with the Divorce Complaint. Next step is to see what <defendant_full_name> will do. /<spain/>Felicitaciones ha terminado con la demanda de divorcio. Siguiente paso es ver qué <defendant_full_name> va hacer. *'

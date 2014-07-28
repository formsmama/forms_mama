module PdfDocument
  class DivorceInjunction < DocumentWrapper
    def initialize(document)

      @document_id = document.id
      @data_array = Array.new

      #Step zero
      steps     = document.template.steps.to_enum
      answers   = step_answers_enum steps.next
      clark_nye = answers.next.answer.strip

      #First step   Your information
      answers = step_answers_enum steps.next

      plaintiff_first_name  = answers.next.answer
      plaintiff_middle_name = answers.next.answer
      plaintiff_last_name   = answers.next.answer

      #Second step   Your Spouse\'s Information
      answers = step_answers_enum steps.next

      defendant_first_name  = answers.next.answer
      defendant_middle_name = answers.next.answer
      defendant_last_name   = answers.next.answer

      #Step 3   Marriage Information
      answers = step_answers_enum steps.next

      in_the_us = answers.next.answer == 'In the United States'
      marriage_city = answers.next.answer
      marriage_state = answers.next.answer

      marriage_city_town_province = answers.next.answer
      marriage_country = answers.next.answer
      marriage_date = answers.next.answer

      marriage_country_string = "#{ in_the_us ? marriage_city : marriage_city_town_province }"
      marriage_country_string += in_the_us ? " State of #{ marriage_state }" : " Country of #{ marriage_country }"



      header_margin_top = 40
      text_indent = 20

      push_text 'cc12'

      push_header "#{ clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT"
      push_header "#{ clark_nye } JUDICIAL DISTRICT COURT"
      move_down 40

      push_text_right 'Case No ______________________'
      move_down
      push_text_right 'Dept. No ______________________'

      push_text "#{ plaintiff_first_name } #{ plaintiff_middle_name } #{ plaintiff_last_name } Plaintiff,"
      push_text 'vs.'
      push_text "#{ defendant_first_name } #{ defendant_middle_name } #{ defendant_last_name } Defendant"

      push_text '__________________________________         JOINT PRELIMINARY INJUNCTION'
      move_down 15

      push_text 'NOTICE!  THIS INJUNCTION IS EFFECTIVE UPON THE PARTY REQUESTING SAME WHEN ISSUED AND AGAINST THE OTHER PARTY WHEN SERVED.  THIS INJUNCTION SHALL REMAIN IN EFFECT FROM THE TIME OF ITS ISSUANCE UNTIL TRIAL OR UNTIL DISSOLVED OR MODIFIED BY THE COURT.  DISOBEDIENCE OF THIS INJUNCTION IS PUNISHABLE BY CONTEMPT.'
      move_down 20
      push_text 'TO: Plaintiff and Defendant:'

      move_down
      push_text 'YOU ARE HEREBY PROHIBITED AND RESTRAINED FROM:', text_indent
      move_down
      push_text '1. Transferring, encumbering, concealing, selling or otherwise disposing of any of your', text_indent
      push_text 'joint, common or community property, except in the usual course of business or for ', text_indent + 15
      push_text 'the necessities of life, without the written consent of the parties or the permission of the.', text_indent + 15
      push_text 'court.', text_indent + 15
      move_down
      push_text '2. Molesting, harassing, disturbing the peace or committing an assault or battery upon', text_indent
      push_text 'your spouse or your child or step-child.', text_indent + 15
      move_down
      push_text '3. Removing any child of the parties then residing in the state of Nevada with an intent', text_indent
      push_text 'or effect to deprive the court of jurisdiction as to said child without the prior written', text_indent + 15
      push_text 'consent of the parties or the advance permission of the court.', text_indent + 15

      move_down 40
      push_text 'Submitted by:                                                          Clerk of the Court'
      move_down 30
      push_text '____________________________                        By: ____________________________'
      move_down 5
      push_text 'Signature                                                                 Deputy Clerk'
      move_down 5
      push_text "#{ plaintiff_first_name } #{ plaintiff_middle_name } #{ plaintiff_last_name }"

      @data_array_enum = @data_array.to_enum
    end
  end
end
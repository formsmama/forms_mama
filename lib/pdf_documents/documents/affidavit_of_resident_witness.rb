module PdfDocument
  class AffidavitOfResidentWitness < DivorceWrapper

    def can_generate?
      @packet =~ /Joint/
    end

    def generate
      _counter = 0
      default_leading 2
      move_down 40
      push_text '<b>AFFT</b>'

      push_text @plaintiff_full_name
      push_text "#{ @plaintiff_mailing_addres } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }"

      push_text @plaintiff_phone
      push_text @plaintiff_email
      push_text 'Self-Represented'
      move_down 5

      push_text @defendant_full_name
      push_text "#{ @defendant_mailing_addres } #{ @defendant_city }, #{ @defendant_state }#{ @defendant_country } #{ @defendant_zip }"

      push_text @defendant_phone
      push_text @defendant_email
      push_text 'Self-Represented'

      move_down 40
      push_header "IN THE #{ @clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT OF THE"
      push_header "STATE OF NEVADA, IN AND FOR THE COUNTY OF #{ @clark_nye.upcase }"
      move_down 20


      table_row [ { :content => "In the Matter of the Marriage of\n #{ @plaintiff_full_name },\n\nand\n\n#{ @defendant_full_name },\nJoint Petitioners.", :width => 300 },
                  { :content => "\nCASE No.:\n\nDEPT No.:", :width => 240 } ]
      push_table -1, 0

      default_leading 8
      move_down 40
      push_header '<b><u>AFFIDAVIT OF RESIDENT WITNESS</u></b>'
      move_down 20
      default_leading 7

      push_text "I, #{ @witness[:full_name] }, swear under penalty of perjury that the following statements are true and correct."

      push_text "1.  I am over the age of eighteen (18) and competent to testify of my own knowledge to the following.", @text_indent * 1.5
      push_text "2.  I have lived in the State of Nevada since #{ @witness[:moved_date].year } and currently live at #{ @witness[:address] } #{ @witness[:city] }, #{ @witness[:state] } #{ @witness[:zip] }. It is my intention to live in the State of Nevada for the foreseeable future.", @text_indent * 1.5
      push_text "3.  To my personal knowledge, #{ @plaintiff_full_name } lives at #{ @plaintiff_mailing_addres } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip } and has been physically living within the State of Nevada on a daily basis for at least six (6) weeks prior to the filing of this action.", @text_indent * 1.5
      push_text "4.  To my personal knowledge, #{ @plaintiff_full_name } has physically lived in the State of Nevada since #{ @witness[:meet_date].month }/#{ @witness[:meet_date].year }.", @text_indent * 1.5
      push_text "5.  I know #{ @plaintiff_full_name } because we are #{ @witness[:relationship].downcase }.", @text_indent * 1.5
      push_text "6.  I see (ISERT him/her) on average #{ @witness[:see_times] } times per week.", @text_indent * 1.5
      push_text "7.  I know of my own personal knowledge that #{ @plaintiff_full_name } is a bona fide resident of the State of Nevada.", @text_indent * 1.5

      move_down 40
      push_text 'DATED this_______day of ___________, 20___.'

      move_down 30
      default_leading 0
      table_row [ { :content => '', :width => 300, :border_width => 0 },
                  { :content => "#{'_'*40} \n SIGNATURE \n\n #{ @witness[:full_name] }", :width => 240, :border_width => 0  } ]
      push_table -1, 0

      move_down
      push_text 'SUBSCRIBED and SWORN to before me this'
      push_text '_______day of ___________, 20___.'
      push_text "By #{ @witness[:full_name] }"
      move_down 20
      default_leading 014
      push_text '______________________'
      push_text 'NOTARY PUBLIC'

      finishing
    end
  end
end
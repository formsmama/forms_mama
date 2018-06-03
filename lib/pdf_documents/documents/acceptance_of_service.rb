module PdfDocument
  class AcceptanceOfService < DivorceWrapper

    def can_generate?
      @filed_case[:person_who_give] =~ /accept/ && @packet =~ /Divorce/
    end

    def generate
      _counter = 0
      default_leading 2
      push_text 'ACSR', :style => :bold

      push_text @plaintiff_full_name
      push_text "#{ @plaintiff_mailing_addres } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }"

      push_text @plaintiff_phone
      push_text @plaintiff_email
      push_text 'Self-Represented', :style => :bold

      move_down 40
      push_header "IN THE #{ @clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT OF THE"
      push_header "STATE OF NEVADA, IN AND FOR THE COUNTY OF #{ @clark_nye.upcase }"
      move_down 20


      table_row [ { :content => "#{ @plaintiff_full_name }\nPlaintiff,\n\nvs.\n\n#{ @defendant_full_name }\nDefendant.", :width => 300, :font_style => :bold },
                  { :content => "\nCASE  NO.: #{ @filed_case[:case] }\n\n\nDEPT NO.: #{ @filed_case[:dept] }", :width => 240 } ]
      push_table -1, 0

      default_leading 8
      move_down 20
      push_text ' '
      push_text ' '
      push_header 'ACCEPTANCE OF SERVICE'
      move_down 15
      push_text "I, #{ @defendant_full_name }, the Defendant in the above stated action accept service of #{'SUMMONS, COMPLAINT'}#{ ', JOINT PRELIMINARY INJUCTION' if @filed_case[:preliminary_injunction_date].present? }."

      move_down 40
      push_text 'DATED this_______day of ___________, 20___.'

      move_down 30
      default_leading 0
      table_row [ { :content => '', :width => 300, :font_style => :bold, :border_width => 0  },
                  { :content => "\n #{'_'*40} \n Signature \n\n\n #{'_'*40} \n #{ @defendant_full_name }", :width => 240, :border_width => 0  } ]
      push_table -1, 0

      finishing
    end
  end
end
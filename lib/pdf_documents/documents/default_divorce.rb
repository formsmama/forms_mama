module PdfDocument
  class DefaultDivorce < DivorceWrapper
    def generate
      push_text '<b>DFLT</b>'
      move_down
      push_text @plaintiff_full_name
      push_text "#{ @plaintiff_mailing_address } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }"
      push_text @plaintiff_phone
      push_text @plaintiff_email
      push_text 'Self-Represented'
      move_down 20

      push_header "IN THE #{ @clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT OF THE"
      push_header "STATE OF NEVADA, IN AND FOR THE COUNTY OF #{ @clark_nye.upcase }"
      move_down 40

      push_text "<u>#{ @plaintiff_full_name }</u>", 40
      push_text "Plaintiff,#{ ' '*57 }CASE NO.: #{ '_'*20 }", 40
      move_down
      push_text "vs.#{ ' '*66 }DEPT NO.: #{ '_'*20 }", 40
      move_down
      push_text "<u>#{ @defendant_full_name }</u>", 40
      push_text 'Defendant', 40
      move_down

      push_header "<b>DEFAULT</b>"
      push_text "It appearing from the files and records in the above entitled action that #{ @defendant_full_name }, Defendant herein, being duly served with a copy of the #{ @filed_case[:preliminary_injunction] ? "Complaint for divorce, Summons on the #{ @filed_case[:summons_and_complaint_date].to_date.strftime('%d day of %B, %Y') } and Joint Preliminary Injunction on the #{ @filed_case[:preliminary_injunction_date].to_date.strftime('%d day of %B, %Y') }" : "Complaint for Divorce and Summons on the #{ @filed_case[:summons_and_complaint_date].to_date.strftime('%d day of %B, %Y') }" }; that more than 20 days, exclusive of the day of service, having been filed and no further time having been granted, the default of the above-named Defendant for failing to answer or otherwise plead to Plaintiff’s Complaint is hereby entered.", @text_indent
      move_down 20

      push_header "CLERK OF THE COURT"
      move_down 40
      push_text "By: #{ '_'*32 }", 280
      push_text "Deputy Clerk                      Date ", 300
      move_down 20

      push_text "Submitted by: #{ '_'*27 }"
      push_text "#{ @plaintiff_full_name }"

      finishing
    end
  end
end
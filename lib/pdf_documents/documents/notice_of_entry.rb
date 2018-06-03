module PdfDocument
  class NoticeOfEntry < DivorceWrapper
    def generate
      push_text '<b>NEOJ</b>'
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
      push_header "<b>NOTICE OF ENTRY OF (INSERT DECREE OF DIVORCE/ SEPARATE MAINTENANCE/ANNULMENT)</b>"
      push_text "TO: #{ @defendant_full_name }, Defendant;", @text_indent
      push_text "(insert only if other party has an attorney) TO: (insert name of the attorney), Defendant’s Attorney", @text_indent
      push_text "PLEASE TAKE NOTICE that a (insert Decree of Divorce, Decree of Annulment, Decree of Separated Maintenance) was duly entered in the above referenced case on the (insert date)  day of (insert month), (insert year).", @text_indent
      move_down 40

      push_text 'DATED this _______day of  ___________, 20___'
      move_down 40
      default_leading 0
      push_text "Submitted by: #{ '_'*27 }", 190
      push_text "#{ @plaintiff_full_name } Signature", 260
      push_text "#{ @plaintiff_mailing_address } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }", 260
      push_text @plaintiff_phone, 260
      push_text @plaintiff_email, 260
      push_text 'Self-Represented', 260

      finishing
    end
  end
end
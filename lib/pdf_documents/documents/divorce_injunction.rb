module PdfDocument
  class DivorceInjunction < DivorceWrapper

    def can_generate?
      @packet =~ /Divorce/
    end

    def generate
      push_text 'CC12'

      push_header "IN THE #{ @clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT OF THE"
      push_header "STATE OF NEVADA, IN AND FOR THE COUNTY OF #{ @clark_nye.upcase }"
      move_down 40

      table_row [ { :content => "#{ @plaintiff_full_name },\n                    Plaintiff,\nvs.\n\n#{ @defendant_full_name },\n#{ ' '*20 }Defendant.\n#{ '_'*20 }", :width => 300, :font_style => :bold, :border_width => 0 },
                  { :content => "CASE No.:\n\nDEPT No.:\n\n<b><u>JOINT PRELIMINARY INJUNCTION</b>", :width => 240, :border_width => 0 } ]
      push_table -1, 0
      move_down 30

      push_text '<b>NOTICE!  THIS INJUNCTION IS EFFECTIVE UPON THE PARTY REQUESTING SAME WHEN ISSUED AND AGAINST THE OTHER PARTY WHEN SERVED.  THIS INJUNCTION SHALL REMAIN IN EFFECT FROM THE TIME OF ITS ISSUANCE UNTIL TRIAL OR UNTIL DISSOLVED OR MODIFIED BY THE COURT.  DISOBEDIENCE OF THIS INJUNCTION IS PUNISHABLE BY CONTEMPT.</b>'
      move_down 20
      push_text '<b>TO: Plaintiff and Defendant:</b>'

      move_down
      push_text '<b>YOU ARE HEREBY PROHIBITED AND RESTRAINED FROM:</b>', @text_indent
      move_down
      push_text '1. Transferring, encumbering, concealing, selling or otherwise disposing of any of your', @text_indent
      push_text 'joint, common or community property, except in the usual course of business or for ', @text_indent + 15
      push_text 'the necessities of life, without the written consent of the parties or the permission of the.', @text_indent + 15
      push_text 'court.', @text_indent + 15
      move_down
      push_text '2. Molesting, harassing, disturbing the peace or committing an assault or battery upon', @text_indent
      push_text 'your spouse or your child or step-child.', @text_indent + 15
      move_down
      push_text '3. Removing any child of the parties then residing in the state of Nevada with an intent', @text_indent
      push_text 'or effect to deprive the court of jurisdiction as to said child without the prior written', @text_indent + 15
      push_text 'consent of the parties or the advance permission of the court.', @text_indent + 15

      clerk_or_judge  = @clark_nye == 'Nye' ? 'JUDGE' : 'CLERK OF COURT'
      deputy_or_judge = @clark_nye == 'Nye' ? 'Judge' : 'Deputy Clerk'

      move_down 40
      table_row [ { :content => 'Submitted by:', :width => 300, :border_width => 0 }, { :content => clerk_or_judge, :width => 240, :border_width => 0 } ]
      table_row [ { :content => '_'*35, :width => 300, :border_width => 0 }, { :content => '_'*35, :width => 240, :border_width => 0 } ]
      table_row [ { :content => 'Signature', :width => 300, :border_width => 0 }, { :content => deputy_or_judge, :width => 240, :border_width => 0 } ]
      table_row [ { :content => "#{ @plaintiff_full_name }", :width => 300, :border_width => 0 }, { :content => "#{  }", :width => 240, :border_width => 0 } ]
      push_table -1, 0

      finishing
    end
  end
end
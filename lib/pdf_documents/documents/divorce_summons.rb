module PdfDocument
  class DivorceSummons < DivorceWrapper

    def can_generate?
      @packet =~ /Divorce/
    end

    def generate
      push_text '<font size="7">SUMM</font>'
      push_header "IN THE #{ @clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT OF THE"
      push_header "STATE OF NEVADA, IN AND FOR THE COUNTY OF #{ @clark_nye.upcase }"
      move_down 30

      table_row [ { :content => "#{ @plaintiff_full_name }\nPlaintiff,\n\nvs.\n\n#{ @defendant_full_name }\nDefendant.", :width => 300, :font_style => :bold },
                  { :content => "\nCASE  NO.:\n\n\nDEPT NO.:", :width => 240 } ]
      push_table -1, 0

      move_down 20
      push_header '<b><u>SUMMONS</u></b>'

      move_down 15

      push_text '<b>NOTICE!  YOU HAVE BEEN SUED.  THE COURT MAY DECIDE AGAINST YOU WITHOUT YOUR BEING HEARD UNLESS YOU RESPOND WITHIN 20 DAYS.  READ THE INFORMATION BELOW.</b>'
      move_down
      push_text "<b>TO THE DEFENDANT:</b> #{ @defendant_full_name }"

      move_down
      push_text 'A civil Complaint for Divorce has been filed by the plaintiff against you; this action is brought to recover a judgment dissolving the bonds of matrimony existing between you and the plaintiff.', @text_indent

      move_down
      push_text '1.  If you intend to defend this lawsuit, within 20 days after this Summons is served on you, exclusive of the day of service, you must do the following:', @text_indent
      move_down
      push_text 'a.  File with the Clerk of this Court, whose address is shown below, a formal written', @text_indent * 2
      push_text 'response to the Complaint in accordance with the rules of the Court.', @text_indent * 2 + 18
      push_text 'b. Serve a copy of your response upon the attorney whose name and address is shown', @text_indent * 2
      push_text 'below.', @text_indent * 2 + 18
      move_down 20
      push_text '2.  Unless you respond, your default will be entered upon application of the plaintiff and this Court may enter a judgment against you for the relief demanded in the Complaint, which could result in the taking of money or property or other relief requested in the Complaint.', @text_indent
      move_down
      push_text '3.  If you intend to seek the advice of an attorney in this matter, you should do so promptly so that your response may be filed on time.', @text_indent

      deputy_clerk_info = case @clark_nye
        when 'Clark'
          "Family Courts and Services Center\n601 North Pecos Road\nLas Vegas, Nevada 89101"
        when 'Nye'
          "1520 E. Basin Ave. Ste. 108\nPahrump, NV 89060"
        when 'Esmeralda'
          "Esmeralda County Clerk Office\nP.O. Box 547\nGoldfield, NV 89013"
        when 'Mineral'
          "Mineral County Clerk Office\nP.O. Box 1450\nHawthorne, NV 89415"
        end

      move_down 40
      table_row [ { :content => 'Submitted by:', :width => 300, :border_width => 0 }, { :content => 'Clerk of the Court', :width => 240, :border_width => 0 } ]
      table_row [ { :content => '_'*35, :width => 300, :border_width => 0 }, { :content => "By: #{ '_'*35 }", :width => 240, :border_width => 0 } ]
      table_row [ { :content => 'Signature', :width => 300, :font_style => :bold, :border_width => 0 }, { :content => 'Deputy Clerk', :width => 240, :font_style => :bold, :border_width => 0 } ]
      table_row [ { :content => "#{ @plaintiff_full_name }", :width => 300, :border_width => 0 }, { :content => "#{ deputy_clerk_info }", :width => 240, :border_width => 0 } ]
      push_table -1, 0

      @data_array_enum = @data_array.to_enum
      self
    end
  end
end
module PdfDocument
  class DivorceCoversheet < DivorceWrapper

    def can_generate?
      @clark_nye != 'Clark'
    end

    def generate
      push_header "CIVIL (FAMILY - RELATED) COVER SHEET"
      push_header "#{ @clark_nye } COUNTY, NEVADA"
      move_down 20

      push_header "Case No. #{ '_'*30 }  (Assigned by Clerk’s Office)", 12
      move_down 10

      push_text '<b>I. PARTY INFORMATION</b>'
      table_row [ { :content => 'Plaintiff/Petitioner', :colspan => 2, :align => :center, :font_style => :bold, :width => 270 }, { :content => 'Defendant/Respondent/Co-Petitioner', :colspan => 2, :align => :center, :font_style => :bold, :width => 270 } ]
      default_leading 4
      table_row [ { :content => "Name: #{ @plaintiff_full_name }
                                Address: #{ @plaintiff_mailing_address }
                                City, State, Zip: #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state }, #{ @plaintiff_mailing_address_zip }
                                Phone #: #{ @plaintiff_phone }
                                Date of Birth: #{ @plaintiff_date_of_birth }
                                <b>Attorney Information (Name/Address/Phone)</b>\n\n\n\n", :colspan => 2 },
                  { :content => "Name: #{ @defendant_full_name }
                                Address: #{ @defendant_mailing_address }
                                City, #{ @defendant_country.present? ? 'Country' : 'State' }, Zip: #{ @defendant_city }, #{ @defendant_country }#{ @defendant_state }, #{ @defendant_zip }
                                Phone #: #{ @defendant_phone }
                                Date of Birth: #{ @defendant_date_of_birth }
                                <b>Attorney Information (Name/Address/Phone)</b>", :colspan => 2 } ]

      push_table
      default_leading 0
      move_down 20

      push_text '<b>II. NATURE OF CONTROVERSY</b>'
      push_header "<b>Family-Related Cases</b>", 12
      table_row [ { :content => 'Domestic Relations', :colspan => 2, :align => :center, :font_style => :bold, :width => 270 }, { :content => 'Guardianship', :colspan => 2, :align => :center, :font_style => :bold, :width => 270 } ]
      default_leading 4
      table_row [ { :content => "<b>Marriage Dissolution Case</b>\n\b\b\b\b\b\b\b\b\b\bAnnulment\n\b\b\b\b\b\b\b\b\b\bDivorce –With children\n\b\b\b\b\b\b\b\b\b\bDivorce –Without children\n\b\b\b\b\b\b\b\b\b\bForeign Decree\n\b\b\b\b\b\b\b\b\b\bJoint Petition – With children\n\b\b\b\b\b\b\b\b\b\bJoint Petition – Without children\n\b\b\b\b\b\b\b\b\b\bSeparate Maintenance\n\n<b>\b\b\b\b\bSupport/Custody</b>\n<b>\b\b\b\b\bUIFSA Case (formerly URESA)</b>\n<b>\b\b\b\b\bAdoption</b>\n\b\b\b\b\b\b\b\b\b\bAdult\n\b\b\b\b\b\b\b\b\b\bMinor\n<b>\b\b\b\b\bPaternity</b>\n<b>\b\b\b\b\bTermination of Parental Rights</b>\n<b>\b\b\b\b\bMiscellaneous Domestic Relations</b>\n\b\b\b\b\b\b\b\b\b\bName Change\n\b\b\b\b\b\b\b\b\b\bPermission to Marry\n\b\b\b\b\b\b\b\b\b\bOther Family", :colspan => 2 },
                  { :content => "<b>\b\b\b\b\bGuardianship of an Adult</b>\n<b>\b\b\b\b\bGuardianship of a Minor</b>\n<b>\b\b\b\b\bGuardianship Trust</b>\n<b>Estimated Estate Value: $</b>\n\n<b>Other Family-Related Case Filing Type</b>\n<b>\b\b\b\b\bMental Health</b>\n<b>\b\b\b\b\bRequest for Temporary Protective Order</b>\n<b>\b\b\b\b\bMiscellaneous Juvenile</b>\n\b\b\b\b\b\b\b\b\b\bEmancipation", :colspan => 2 } ]
      small_rectangle 12, 437

      if @children_residency
        small_rectangle_checked 12, 424
        small_rectangle 12, 411
      else
        small_rectangle 12, 424
        small_rectangle_checked 12, 411
      end

      small_rectangle 12, 398
      small_rectangle 12, 387
      small_rectangle 12, 372
      small_rectangle 12, 359
      small_rectangle 2, 333
      small_rectangle 2, 320
      small_rectangle 2, 307
      small_rectangle 12, 294
      small_rectangle 12, 281
      small_rectangle 2, 269
      small_rectangle 2, 255
      small_rectangle 2, 242
      small_rectangle 12, 229
      small_rectangle 12, 216
      small_rectangle 12, 203

      small_rectangle 273, 450
      small_rectangle 273, 437
      small_rectangle 273, 424
      small_rectangle 273, 371
      small_rectangle 273, 358
      small_rectangle 273, 345
      small_rectangle 281, 332

      create_line 270, 540, 385
      create_line 270, 540, 374

      push_table -1
      move_down 20
      default_leading 0

      push_text '<b>Children involved in this case:</b>'
      move_down 10

      if @children_residency
        table_row []
        @children_info.each do |child|
          table_row [{ :content => "Name: #{ child[:first_name] } #{ child[:last_name] } #{ child[:middle_name] }", :border_width => 0 }, { :content => "DOB: #{ child[:date_of_birth] }", :border_width => 0 }]
        end
        push_table -1, 0
        move_down 20
      end


      push_text "<u>#{ ' '*10 } #{ Time.now.strftime("%m-%d-%Y") } #{ ' '*60 }</u> #{ ' '*15 } #{ '_'*30 }"
      push_text "#{ ' '*10 } Date #{ ' '*85 } Signature of Preparer #{ @plaintiff_full_name }"

      finishing
    end
  end
end
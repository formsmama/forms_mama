module PdfDocument
  class WelfareSheet < DivorceWrapper

    def can_generate?
      @children_residency && @packet =~ /Joint/
    end

    def generate
      push_header "<b>NEVADA STATE DIVISION OF WELFARE AND SUPPORTIVE SERVICES</b>"
      push_header "<b>CHILD SUPPORT ENFORCEMENT</b>"
      move_down 10
      push_header "IN THE FAMILY DIVISION"
      push_header "OF THE #{ @clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT OF THE STATE OF NEVADA"
      push_header "IN AND FOR THE COUNTY OF #{ @clark_nye.upcase }"
      move_down 10
      push_header "<b>CONFIDENTIAL FAMILY COURT INFORMATION SHEET</b>"
      move_down 10

      push_text "<u>#{ @plaintiff_full_name }</u>", 40
      push_text "Plaintiff/Petitioner#{ ' '*51 }Case No.: #{ '_'*20 }", 40
      move_down 10
      push_text "vs.#{ ' '*76 }Dept No.: #{ '_'*20 }", 40
      move_down 10
      push_text "<u>#{ @defendant_full_name }</u>", 40
      push_text 'Defendant/Respondent', 40
      move_down 10

      table_row [{ :content => "<b>Mother/Wife Information</b>\nCustodial Parent      Non-Custodial Parent", :border_width => 0, :align => :center }, { :content => "<b>Father/Husband Information</b>\nCustodial Parent      Non-Custodial Parent", :border_width => 0, :align => :center }]
      table_row [{ :content => "Name: #{ @mom == 'plaintiff' ? @plaintiff_full_name : @defendant_full_name }", :border_width => 0 }, { :content => "Name: #{ @mom == 'plaintiff' ? @defendant_full_name : @plaintiff_full_name }", :border_width => 0 }]

      second_text_column, text_column = @mom == 'plaintiff' ? [@defendant_social_security, @plaintiff_social_security] : [@plaintiff_social_security, @defendant_social_security]
      table_row [{ :content => "Social Security Number: #{ text_column.present? ? text_column : 'None' }", :border_width => 0 }, { :content => "Social Security Number: #{ second_text_column.present? ? second_text_column : 'None' }", :border_width => 0 }]
      table_row [{ :content => "Date of Birth: #{ @mom == 'plaintiff' ? @plaintiff_date_of_birth : @defendant_date_of_birth }", :border_width => 0 }, { :content => "Date of Birth: #{ @mom == 'plaintiff' ? @defendant_date_of_birth : @plaintiff_date_of_birth }", :border_width => 0 }]
      table_row [{ :content => "Residential Address: #{ @mom == 'plaintiff' ? @plaintiff_home_address : @defendant_mailing_address }", :border_width => 0 }, { :content => "Residential Address: #{ @mom == 'plaintiff' ? @defendant_mailing_address : @plaintiff_home_address }", :border_width => 0 }]
      table_row [{ :content => "City, State, Zip: #{ @mom == 'plaintiff' ? "#{ @plaintiff_home_address_city} #{ @plaintiff_home_address_state } #{ @plaintiff_home_address_zip }" : "#{ @defendant_city } #{ @defendant_country }#{ @defendant_state } #{ @defendant_zip }" }", :border_width => 0 }, { :content => "City, State, Zip: #{ @mom == 'plaintiff' ? "#{ @defendant_city } #{ @defendant_country }#{ @defendant_state } #{ @defendant_zip }" : "#{ @plaintiff_home_address_city} #{ @plaintiff_home_address_state } #{ @plaintiff_home_address_zip }" }", :border_width => 0 }]
      table_row [{ :content => "Mailing Address: #{ @mom == 'plaintiff' ? @plaintiff_mailing_address : @defendant_mailing_address }", :border_width => 0 }, { :content => "Mailing Address: #{ @mom == 'plaintiff' ? @defendant_mailing_address : @plaintiff_mailing_address }", :border_width => 0 }]
      table_row [{ :content => "#{ @mom == 'plaintiff' ? "#{ @plaintiff_mailing_address_city } #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }" : "#{ @defendant_city } #{ @defendant_country }#{ @defendant_state } #{ @defendant_zip }" }", :border_width => 0 }, { :content => "#{ @mom == 'plaintiff' ? "#{ @defendant_city } #{ @defendant_country }#{ @defendant_state } #{ @defendant_zip }" : "#{ @plaintiff_mailing_address_city } #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }" }", :border_width => 0 }]

      second_text_column, text_column = @mom == 'plaintiff' ? [@defendant_phone, @plaintiff_phone] : [@defendant_phone, @plaintiff_phone]
      table_row [{ :content => "Telephone No.: #{ text_column.present? ? text_column : 'N/A' }", :border_width => 0 }, { :content => "Telephone No.: #{ second_text_column.present? ? second_text_column : 'N/A' }", :border_width => 0 }]

      second_text_column, text_column = @mom == 'plaintiff' ? [@defendant_drivers_license, @plaintiff_drivers_license] : [@plaintiff_drivers_license, @defendant_drivers_license]
      table_row [{ :content => "Driver’s License No.: #{ text_column.present? ? text_column : 'None' }", :border_width => 0 }, { :content => "Driver’s License No.: #{ second_text_column.present? ? second_text_column : 'None' }", :border_width => 0 }]
      table_row [{ :content => "Ethnicity:       White (Non Hispanic)      Hispanic\n\b\b\b\bAfrican-American      Asian or Pacific Islander\n\b\b\b\bNative American/Alaskan Native      Other", :border_width => 0 }, { :content => "Ethnicity:      White (Non Hispanic)      Hispanic\n\b\b\b\bAfrican-American      Asian or Pacific Islander\n\b\b\b\bNative American/Alaskan Native      Other", :border_width => 0 }]
      table_row [{ :content => "Are you employed?      YES      NO", :border_width => 0 }, { :content => "Are you employed?      YES      NO", :border_width => 0 }]

      second_text_column, text_column = @mom == 'plaintiff' ? [@defendant_employer_name, @plaintiff_employer_name] : [@defendant_employer_name, @plaintiff_employer_name]
      table_row [{ :content => "Name of Employer: #{ text_column.present? ? text_column : 'N/A' }", :border_width => 0 }, { :content => "Name of Employer: #{ second_text_column.present? ? second_text_column : 'N/A' }", :border_width => 0 }]

      second_text_column, text_column = @mom == 'plaintiff' ? [@defendant_business_address, @plaintiff_business_address] : [@plaintiff_business_address, @defendant_business_address]
      table_row [{ :content => "Business Address: #{ text_column.present? ? text_column : 'N/A' }", :border_width => 0 }, { :content => "Business Address: #{ second_text_column.present? ? second_text_column : 'N/A' }", :border_width => 0 }]

      second_text_column, text_column = @mom == 'plaintiff' ? ["#{ @defendant_employer_city } #{ @defendant_employer_state } #{ @defendant_employer_zip }", "#{ @plaintiff_employer_city } #{ @plaintiff_employer_state } #{ @plaintiff_employer_zip }"] : ["#{ @plaintiff_employer_city } #{ @plaintiff_employer_state } #{ @plaintiff_employer_zip }", "#{ @defendant_employer_city } #{ @defendant_employer_state } #{ @defendant_employer_zip }"]
      table_row [{ :content => "City, State, Zip: #{ text_column.present? ? text_column : 'N/A' }", :border_width => 0 }, { :content => "City, State, Zip: #{ second_text_column.present? ? second_text_column : 'N/A' }", :border_width => 0 }]

      second_text_column, text_column = @mom == 'plaintiff' ? [@defendant_employer_phone, @plaintiff_employer_phone] : [@plaintiff_employer_phone, @defendant_employer_phone]
      table_row [{ :content => "Telephone No.: #{ text_column.present? ? text_column : 'N/A' }", :border_width => 0 }, { :content => "Telephone No.: #{ second_text_column.present? ? second_text_column : 'N/A' }", :border_width => 0 }]
      push_table -1, 0
      move_down

      y_coordinate = 508
      @legal_custody_parent.each do |legal_custody|
        case legal_custody
        when 'BOTH Parents'
          small_rectangle_checked 43, y_coordinate
          small_rectangle 124, y_coordinate
          small_rectangle_checked 312, y_coordinate
          small_rectangle 394, y_coordinate
        when 'Only MOM'
          small_rectangle_checked 43, y_coordinate
          small_rectangle 124, y_coordinate
          small_rectangle 312, y_coordinate
          small_rectangle_checked 394, y_coordinate
        when 'Only DAD'
          small_rectangle 43, y_coordinate
          small_rectangle_checked 124, y_coordinate
          small_rectangle_checked 312, y_coordinate
          small_rectangle 394, y_coordinate
        end
      end

      coordinates_array = [{ :x => 49, :y => 327 }, { :x => 153, :y => 327 }, { :x => 4, :y => 316 }, { :x => 91, :y => 316 }, { :x => 4, :y => 305 }, { :x => 150, :y => 305 }]
      _ethnicity = @plaintiff_ethnicity
      2.times do
        case _ethnicity
        when 'White (Non-Hispanic)'
          small_rectangle_checked coordinates_array[0][:x], coordinates_array[0][:y]
          coordinates_array.shift
        when 'Hispanic'
          small_rectangle_checked coordinates_array[1][:x], coordinates_array[1][:y]
          coordinates_array.delete_at(1)
        when 'African-American'
          small_rectangle_checked coordinates_array[2][:x], coordinates_array[2][:y]
          coordinates_array.delete_at(2)
        when 'Asian or Pacific Islander'
          small_rectangle_checked coordinates_array[3][:x], coordinates_array[3][:y]
          coordinates_array.delete_at(3)
        when 'Native American or Alaskan Native'
          small_rectangle_checked coordinates_array[4][:x], coordinates_array[4][:y]
          coordinates_array.delete_at(4)
        when 'Other'
          small_rectangle_checked coordinates_array[5][:x], coordinates_array[5][:y]
          coordinates_array.pop
        end

        coordinates_array.each do |coordinate|
          small_rectangle coordinate[:x], coordinate[:y]
        end

        coordinates_array = [{ :x => 317, :y => 327 }, { :x => 421, :y => 327 }, { :x => 274, :y => 316 }, { :x => 361, :y => 316 }, { :x => 274, :y => 305 }, { :x => 420, :y => 305 }]
        _ethnicity = @defendant_ethnicity
      end

      @plaintiff_employed_presence ? [small_rectangle_checked(87, 286), small_rectangle(120, 286)] : [small_rectangle(87, 286), small_rectangle_checked(120, 286)]

      @defendant_employed_presence ? [small_rectangle_checked(357, 286), small_rectangle(390, 286)] : [small_rectangle(357, 286), small_rectangle_checked(390, 286)]

      coordinates_array = [{ :x => 32, :y => 480}, { :x => 103, :y => 462}, { :x => 60, :y => 444},
                           { :x => 88, :y => 426}, { :x => 68, :y => 408}, { :x => 75, :y => 390},
                           { :x => 3, :y => 372}, { :x => 67, :y => 354}, { :x => 91, :y => 336},
                           { :x => 85, :y => 259}, { :x => 79, :y => 240}, { :x => 69, :y => 222},
                           { :x => 67, :y => 204}
                          ]
      2.times do
        coordinates_array.each do |coordinate|
          create_line coordinate[:x], coordinate[:width].present? ? coordinate[:width] : 260, coordinate[:y]
          coordinate[:width], coordinate[:x] = coordinate[:x] + 270, 530
        end
      end

      if @children_nevada_residency
        push_header "<b>CHILDREN OF THE PARTIES</b>", 10

        table_row [{ :content => "", :colspan => 2, :border_width => 0 }, { :content => "", :border_width => 0 }, { :content => "", :border_width => 0 }, { :content => "<b>Gender</b>", :border_width => 0,  :width => 70 }]
        coordinate_y = 155
        @children_info.each_with_index do |child, index|
          table_row [{ :content => "Name: <u>#{ child[:full_name] }</u>", :colspan => 2, :border_width => 0 }, { :content => "SSN: <u>#{ child[:social_security] }</u>", :border_width => 0, :width => 100 }, { :content => "DOB: <u>#{ child[:date_of_birth] }</u>", :border_width => 0, :width => 100 }, { :content => "M\b\b\b\b\bF", :border_width => 0, :width => 70 }]
          if child[:sex] == 'Male'
            small_rectangle_checked 463, coordinate_y - (index * 18)
            small_rectangle 484, coordinate_y - (index * 18)
          else
            small_rectangle 463, coordinate_y - (index * 18)
            small_rectangle_checked 484, coordinate_y - (index * 18)
          end
          break if index == 4
        end
        push_table -1, 0
        push_header "If there are more than five (5) children, list their information on a separate sheet of paper and attach.",8
        move_down 10
      end

      push_text "Does this case involve Family Violence:       YES       NO"

      if @children_info.present?
        rectangle 245, 142 - (@children_info.count * 18)
        rectangle 202, 142 - (@children_info.count * 18)
      else
        rectangle 245, 191
        rectangle 202, 191
        move_down 10
      end

      table_row [{ :content => "<u>#{ '_'*30 }</u>", :colspan => 2, :border_width => 0, :align => :center }, { :content => "<u>#{ Time.now.strftime("%m-%d-%Y") }</u>", :border_width => 0, :align => :center }, { :content => "<u>#{ '_'*30 }</u>", :colspan => 2, :border_width => 0, :align => :center }, { :content => "<u>#{ Time.now.strftime("%m-%d-%Y") }<u>", :border_width => 0, :align => :center }]
      table_row [{ :content => "Signature", :colspan => 2, :border_width => 0, :align => :center }, { :content => "Date", :border_width => 0, :align => :center }, { :content => "Signature", :colspan => 2, :border_width => 0, :align => :center }, { :content => "Date", :border_width => 0, :align => :center }]
      push_table -1, 0

      start_new_page
      table_row [{ :content => "The information captured on this form will be forwarded to the Federal Case Registry as required by federal law.  If you do not want your identifying information shared with other states because of domestic violence, please check YES to the question on domestic violence.\n
                                Nevada’s Division of Welfare and Supportive Services (DWSS),  Child Support Enforcement Program (CSEP) is required by Chapter 42 of the United States Codes, federal regulations and state laws to obtain the Social Security Numbers (SSNs) of participants in cases involving child support orders.  The CSEP will use these SSNs only for the purposes outlined in the federal law, federal regulations, state laws and state regulations that govern the CSEP.  Social Security Numbers will be maintained in a confidential manner.\n
                                Within ten (10) days after a Nevada court issues a child support order, each party listed in the order must file the following information with the court that issued the order and the Division of Welfare and Supportive Services:\n
                                \b\b\b\b\b\b\b\b\b1.\b\b\b\bSocial Security Number;\n
                                \b\b\b\b\b\b\b\b\b2.\b\b\b\bResidential and mailing address;\n
                                \b\b\b\b\b\b\b\b\b3.\b\b\b\bTelephone number;\n
                                \b\b\b\b\b\b\b\b\b4.\b\b\b\bDriver’s License number, and\n
                                \b\b\b\b\b\b\b\b\b5.\b\b\b\bName, address and telephone number of employer.\n
                                Each party shall update the information filed with the court and the Division of Welfare and Supportive Services (DWSS) within ten (10) days after the information becomes inaccurate.  Information directed to DWSS should be mailed to:\n
                                \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bNevada State Division of Welfare and Supportive Services\n
                                \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bChild Support Enforcement Program\n
                                \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b1470 College Parkway\n
                                \b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\bCarson City, Nevada 89706-7924\n
                                This requirement can be found in Nevada Revised Statutes 125B.055 and 125.230." }, :border_width => 0]
      push_table -2, 0

      if @children_nevada_residency && @children_info.count > 5
        start_new_page
        push_header "<b>ADDITIONAL CHILDREN OF THE PARTIES</b>"
        index = 5
        coordinate_x = 719
        table_row [{ :content => "", :colspan => 2, :border_width => 0 }, { :content => "", :border_width => 0 }, { :content => "", :border_width => 0 }, { :content => "<b>Gender</b>", :border_width => 0 }]
        (@children_info.count - 5).times do
          table_row [{ :content => "Name: <u>#{ @children_info[index][:full_name] }</u>", :colspan => 2, :border_width => 0 }, { :content => "SSN: <u>#{ @children_info[index][:social_security] }</u>", :border_width => 0 }, { :content => "DOB: <u>#{ @children_info[index][:date_of_birth] }</u>", :border_width => 0 }, { :content => "M\b\b\b\b\bF", :border_width => 0 }]
          if @children_info[index][:sex] == 'Male'
            small_rectangle_checked 445, coordinate_x - (index * 18)
            small_rectangle 466, coordinate_x - (index * 18)
          else
            small_rectangle 445, coordinate_x - (index * 18)
            small_rectangle_checked 466, coordinate_x - (index * 18)
          end
          index += 1
        end
        push_table -1, 0
      end

      finishing
    end
  end
end
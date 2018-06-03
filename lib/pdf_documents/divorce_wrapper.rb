module PdfDocument
  class DivorceWrapper < Wrapper
    def initialize(document)

      @header_margin_top = 40
      @text_indent = 20

      @document = document

      @divorce_document = document
      while @divorce_document.previous_document.present? do
        @divorce_document = @divorce_document.previous_document
      end

        @document_id = document.id
        @data_array = Array.new

        if document.template.name == Document::FILED_CASE
    #Filed_Case_Step 1
          steps = document.template.steps.to_enum
          answers = step_answers_enum steps.next
          @filed_case = {}
          @filed_case[:case] = answers.next.answer
          @filed_case[:dept] = answers.next.answer
          answers.next.answer
          answers.next.answer
          @filed_case[:summons_and_complaint_date] = answers.next.answer
          @filed_case[:preliminary_injunction] = answers.next.answer == '1' rescue false
          @filed_case[:preliminary_injunction_date] = answers.next.answer

    #Filed_Case_Step 2
          answers = step_answers_enum steps.next
          answers.next.answer
          @filed_case[:addres_for_opposing_present] = answers.next.answer == 'Yes' rescue false

    #Filed_Case_Step 3
          if @filed_case[:addres_for_opposing_present]
            answers = step_answers_enum steps.next
            @filed_case[:person_who_give] = answers.next.answer
            if @filed_case[:person_who_give] =~ /I have a friend/
              answers.next.answer
              @filed_case[:friend] = {}
              @filed_case[:friend][:first_name] = answers.next.answer
              @filed_case[:friend][:middle_name] = answers.next.answer
              @filed_case[:friend][:last_name] = answers.next.answer
              @filed_case[:friend][:full_name] = "#{ @filed_case[:friend][:first_name] } #{ @filed_case[:friend][:middle_name] } #{ @filed_case[:friend][:last_name] }".squish
              @filed_case[:friend][:address_type] = answers.next.answer.split[0].downcase
              @filed_case[:friend][:address] = answers.next.answer
              @filed_case[:friend][:city] = answers.next.answer
              @filed_case[:friend][:zip] = answers.next.answer
              @filed_case[:friend][:phone] = answers.next.answer
            end
          end
        end


        @document_id = @divorce_document.id
        document = @divorce_document
        #Step 1
        steps = document.template.steps.to_enum
        answers = step_answers_enum steps.next
        @packet = answers.next.answer

        #Step 2
        answers = step_answers_enum steps.next
        @clark_nye = answers.next.answer

        #Step 3   Your information
        answers = step_answers_enum steps.next

        @plaintiff_first_name = answers.next.answer
        @plaintiff_middle_name = answers.next.answer
        @plaintiff_last_name = answers.next.answer
        @plaintiff_full_name = "#{ @plaintiff_first_name } #{ @plaintiff_middle_name } #{ @plaintiff_last_name }".squish

        @plaintiff_date_of_birth = answers.next.answer
        answers.next
        @plaintiff_sex = answers.next.answer
        @plaintiff_social_security = answers.next.answer
        @plaintiff_home_address = answers.next.answer.titleize
        @plaintiff_home_address_city = answers.next.answer.classify
        @plaintiff_home_address_state = answers.next.answer.classify
        @plaintiff_home_address_zip = answers.next.answer.classify
        @plaintiff_mailing_address = answers.next.answer.titleize
        @plaintiff_mailing_address_city = answers.next.answer.classify
        @plaintiff_mailing_address_state = answers.next.answer.classify
        @plaintiff_mailing_address_zip = answers.next.answer.classify
        #@plaintiff_zip = answers.next.answer
        @plaintiff_phone = answers.next.answer
        @plaintiff_email = answers.next.answer

        @mom = 'plaintiff'
        @dad = 'defendant'

        #Step 4   Your Spouse\'s Information
        answers = step_answers_enum steps.next

        @defendant_first_name = answers.next.answer
        @defendant_middle_name = answers.next.answer
        @defendant_last_name = answers.next.answer
        @defendant_full_name = "#{ @defendant_first_name } #{ @defendant_middle_name } #{ @defendant_last_name }".squish

        @defendant_date_of_birth = answers.next.answer
        answers.next
        @defendant_sex = answers.next.answer
        @defendant_social_security = answers.next.answer
        @defendant_mailing_address = answers.next.answer.titleize
        if answers.next.answer == "Outside the United States"
          2.times do answers.next end
          @defendant_city = answers.next.answer.classify
          @defendant_country = answers.next.answer.classify
        else
          @defendant_city = answers.next.answer.classify
          @defendant_state = answers.next.answer.classify
          2.times do answers.next end
        end
        @defendant_zip = answers.next.answer
        @defendant_email = answers.next.answer
        @defendant_phone = answers.next.answer

        if @plaintiff_sex == 'Male' && @defendant_sex == 'Male'
          @spouses = 'Male'
        elsif @plaintiff_sex == 'Female' && @defendant_sex == 'Female'
          @spouses = 'Female'
        else
          @spouses = 'Male and Female'
        end

        #Step 5   Marriage Information
        answers = step_answers_enum steps.next

        @in_the_us = answers.next.answer == 'In the United States'
        @marriage_city = answers.next.answer
        @marriage_state = answers.next.answer

        @marriage_city_town_province = answers.next.answer
        @marriage_country = answers.next.answer
        @marriage_date = answers.next.answer


        @marriage_country_string = "in the city of #{ @in_the_us ? @marriage_city : @marriage_city_town_province }"
        @marriage_country_string += @in_the_us ? " State of #{ @marriage_state }" : " Country of #{ @marriage_country }"
        @marriage_country_string += ' and have since remained married.'

        @marriage_date_decree = @marriage_date.to_date.strftime('%e day of %B, %Y')
        @marriage_country_decree = "in the city of #{ @in_the_us ? @marriage_city : @marriage_city_town_province }"
        @marriage_country_decree += @in_the_us ? " State of #{ @marriage_state } County of #{ @clark_nye }" : " Country of #{ @marriage_country }"

        @marriage_country_string_short = "#{ @in_the_us ? @marriage_city : @marriage_city_town_province }"
        @marriage_country_string_short += @in_the_us ? " State of #{ @marriage_state }" : " Country of #{ @marriage_country }"

        #Step 6   Nevada Residency
        answers = step_answers_enum steps.next

        @lived_in_nevada_since = answers.next.answer

        #Step 7   Pregnacy
        if @spouses == 'Male'
          steps.next
        elsif @spouses == 'Female'
          answers = step_answers_enum steps.next
          6.times do answers.next end
          @pregnacy = answers.next.answer == '0' rescue false
          if @pregnacy
            if @pregnacy_user = answers.next.answer == '1' rescue false
              @pregnacy_user_date = answers.next.answer
            else
              answers.next
            end
            if @pregnacy_spouse = answers.next.answer == '1' rescue false
              @pregnacy_spouse_date = answers.next.answer
            end
          end
        else
          answers = step_answers_enum steps.next
          answers.next
          @pregnacy = answers.next.answer == 'IS currently pregnant'
          if @pregnacy
            @pregnacy_date = answers.next.answer
            answers.next
            @pregnacy_unborn = answers.next.answer == 'Yes'
          end
        end

        #Step 8   Children & Number of children
        answers = step_answers_enum steps.next
        @children_residency = answers.next.answer == 'Yes' rescue false
        answers.next
        @number_of_children = answers.next.answer.to_i

        if !@children_residency
          21.times do steps.next end
        else

          #Step 9   Child(ren)'s Information
          step = steps.next
          @children_info = Array.new

          @number_of_children.times do |i|
            answers = step_answers_enum step, i
            child_info = Hash.new
            child_info[:first_name] = answers.next.answer
            child_info[:middle_name] = answers.next.answer
            child_info[:last_name] = answers.next.answer
            child_info[:full_name] = "#{child_info[:first_name]} #{child_info[:middle_name]} #{child_info[:last_name]}".squish
            child_info[:date_of_birth] = answers.next.answer
            answers.next
            if answers.next.answer == 'In the United States'
              child_info[:city] = answers.next.answer
              child_info[:state] = answers.next.answer
              2.times do answers.next end
            else
              2.times do answers.next end
              child_info[:city] = answers.next.answer
              child_info[:country] = answers.next.answer
            end
            child_info[:social_security] = answers.next.answer
            child_info[:sex] = answers.next.answer == 'Son' ? 'Male' : 'Female'

            @children_info.push child_info
          end

          #Step 10   Legal Custody
          answers = step_answers_enum steps.next

          2.times do answers.next end
          @children_nevada_residency = answers.next.answer == 'Yes' rescue false
          if !@children_nevada_residency
            2.times do answers.next end
            @children_continue = answers.next.answer == 'Yes' rescue false
          end
          if @children_continue
            19.times do steps.next end
          else

            #Step 11   CHILDREN’S ADDRESS
            answers = document.step_answers steps.next

            k = -1
            while answers.count - 1 > k do
              if answers[k+3].toggler_offset % Document::TOGGLER_OFFSET == 0
                @children_info[answers[k+3].toggler_offset / Document::TOGGLER_OFFSET][:addresses] = []
                @children_info[answers[k+3].toggler_offset / Document::TOGGLER_OFFSET][:toggler_offset] = answers[k+3].toggler_offset
                k += 3
              else
                k += 2
              end
              address_data = {}
              address_data[:where] = answers[k].answer
              case address_data[:where]
              when 'In the United States'
                address_data[:address] = answers[k += 2].answer
                address_data[:city] = answers[k += 1].answer
                address_data[:state] = answers[k += 1].answer
                address_data[:zip] = answers[k += 1].answer
                address_data[:move_date] = answers[k += 1].answer.to_date
                address_data[:persone_relationship] = []
                address_data[:lived_with] = []
                3.times do
                  if answers[k += 1].answer == '1'
                    address_data[:persone_relationship] << answers[k].template_field.name.split(' /<spain/>').first.upcase
                    case address_data[:persone_relationship].last
                    when 'OTHER'
                      address_data[:lived_with] << answers[k + 8].answer.upcase
                      address_data[:persone_relationship][-1] = answers[k + 9].answer.upcase
                    when 'MOM'
                      address_data[:lived_with] << (@mom == 'plaintiff' ? "#{ @plaintiff_full_name.upcase }" : "#{ @defendant_full_name.upcase }")
                    when 'DAD'
                      address_data[:lived_with] << (@dad == 'plaintiff' ? "#{ @plaintiff_full_name.upcase }" : "#{ @defendant_full_name.upcase }")
                    end
                  end
                end
                k += 13
                @children_info[answers[k-1].toggler_offset / Document::TOGGLER_OFFSET][:addresses] << address_data
              when 'Outside the United States'
                address_data[:address] = answers[k += 10].answer
                address_data[:city] = answers[k += 1].answer
                address_data[:country] = answers[k += 1].answer
                address_data[:move_date] = answers[k += 1].answer.to_date
                address_data[:persone_relationship] = []
                address_data[:lived_with] = []
                3.times do
                  if answers[k += 1].answer == '1'
                    address_data[:persone_relationship] << answers[k].template_field.name.split(' /<spain/>').first.upcase
                    case address_data[:persone_relationship].last
                    when 'OTHER'
                      address_data[:lived_with] << answers[k + 3].answer.upcase
                      address_data[:persone_relationship][-1] = answers[k + 4].answer.upcase
                    when 'MOM'
                      address_data[:lived_with] << (@mom == 'plaintiff' ? "#{ @plaintiff_full_name.upcase }" : "#{ @defendant_full_name.upcase }")
                    when 'DAD'
                      address_data[:lived_with] << (@dad == 'plaintiff' ? "#{ @plaintiff_full_name.upcase }" : "#{ @defendant_full_name.upcase }")
                    end
                  end
                end
                k += 6
                @children_info[answers[k-1].toggler_offset / Document::TOGGLER_OFFSET][:addresses] << address_data
              when 'Same as me'
                address_data[:move_date] = answers[k += 1].answer.to_date
                address_data[:address] = @plaintiff_home_address
                address_data[:city] = @plaintiff_home_address_city
                address_data[:state] = @plaintiff_home_address_state
                address_data[:zip] = @plaintiff_home_address_zip
                address_data[:persone_relationship] = @plaintiff_wife_husband == 'Wife' ? ['MOM'] : ['DAD']
                address_data[:lived_with] = [@plaintiff_full_name.upcase]
                k += 21
                @children_info[answers[k-1].toggler_offset / Document::TOGGLER_OFFSET][:addresses] << address_data
              end
            end

            #Step 12   CHILDREN’S QUESTION 1
            answers = document.step_answers steps.next
            k = -1
            @number_of_children.times do |i|
              @children_info[i][:toggler_offset] = answers[k + 2].toggler_offset
              has_cases = answers[k += 2].answer == 'Yes' rescue false
              if has_cases
                @children_info[i][:question_1_cases] = []
                case_data = {}
                case_data[:role] = answers[k += 2].answer
                case_data[:role] == 'Other' ? case_data[:role] = answers[k += 1].answer.capitalize : k += 1
                case_data[:name_of_court] = answers[k += 1].answer
                case_data[:state] = answers[k += 1].answer
                case_data[:case_number] = answers[k += 1].answer
                case_data[:date] = answers[k += 1].answer
                k += 2
                @children_info[i][:question_1_cases] << case_data
              else
                k += 9
              end
            end

            if @children_info.select{ |child| child[:question_1_cases] }.present?
              while answers.count - 1 > k do
                case_data = {}
                case_data[:role] = answers[k += 2].answer
                case_data[:role] == 'Other' ? case_data[:role] = answers[k += 1].answer.capitalize : k += 1
                case_data[:name_of_court] = answers[k += 1].answer
                case_data[:state] = answers[k += 1].answer
                case_data[:case_number] = answers[k += 1].answer
                case_data[:date] = answers[k += 1].answer
                k += 2
                if @children_info.select{ |child| (answers[k-1].toggler_offset - child[:toggler_offset]) / Document::TOGGLER_OFFSET == 0 }.first[:question_1_cases].present?
                  @children_info.select{ |child| (answers[k-1].toggler_offset - child[:toggler_offset]) / Document::TOGGLER_OFFSET == 0 }.first[:question_1_cases] << case_data
                end
              end
            end

            #Step 13   CHILDREN’S QUESTION 2
            answers = document.step_answers steps.next
            k = -1
            @number_of_children.times do |i|
              @children_info[i][:toggler_offset] = answers[k + 2].toggler_offset
              has_cases = answers[k += 2].answer == 'Yes' rescue false
              if has_cases
                @children_info[i][:question_2_cases] = []
                case_data = {}
                case_data[:role] = answers[k += 2].answer
                case_data[:role] == 'Other' ? case_data[:role] = answers[k += 1].answer.capitalize : k += 1
                case_data[:name_of_court] = answers[k += 1].answer
                case_data[:state] = answers[k += 1].answer
                case_data[:case_number] = answers[k += 1].answer
                case_data[:date] = answers[k += 1].answer
                k += 2
                @children_info[i][:question_2_cases] << case_data
              else
                k += 9
              end
            end

            if @children_info.select{ |child| child[:question_2_cases] }.present?
              while answers.count - 1 > k do
                case_data = {}
                case_data[:role] = answers[k += 2].answer
                case_data[:role] == 'Other' ? case_data[:role] = answers[k += 1].answer.capitalize : k += 1
                case_data[:name_of_court] = answers[k += 1].answer
                case_data[:state] = answers[k += 1].answer
                case_data[:case_number] = answers[k += 1].answer
                case_data[:date] = answers[k += 1].answer
                k += 2
                if @children_info.select{ |child| (answers[k-1].toggler_offset - child[:toggler_offset]) / Document::TOGGLER_OFFSET == 0 }.first[:question_2_cases].present?
                  @children_info.select{ |child| (answers[k-1].toggler_offset - child[:toggler_offset]) / Document::TOGGLER_OFFSET == 0 }.first[:question_2_cases] << case_data
                end
              end
            end

            #Step 14   CHILDREN’S QUESTION 3
            answers = document.step_answers steps.next
            k = -1
            @number_of_children.times do |i|
              has_cases = answers[k += 2].answer == 'Yes' rescue false
               if has_cases
                @children_info[i][:question_3_cases] = []
                case_data = {}
                case_data[:name] = answers[k += 1].answer
                case_data[:address] = answers[k += 1].answer
                case_data[:rights] = answers[k += 1].answer
                k += 2
                @children_info[i][:question_3_cases] << case_data
              else
                k += 5
              end
            end

            if @children_info.select{ |child| child[:question_3_cases] }.present?
              while answers.count - 1 > k do
                case_data = {}
                case_data[:name] = answers[k += 1].answer
                case_data[:address] = answers[k += 1].answer
                case_data[:rights] = answers[k += 1].answer
                k += 2
                if @children_info.select{ |child| (answers[k-1].toggler_offset - child[:toggler_offset]) / Document::TOGGLER_OFFSET == 0 }.first[:question_3_cases].present?
                  @children_info.select{ |child| (answers[k-1].toggler_offset - child[:toggler_offset]) / Document::TOGGLER_OFFSET == 0 }.first[:question_3_cases] << case_data
                end
              end
            end

            #Step 15   Legal Custody
            answers = step_answers_enum steps.next
            @same_legal_custody = answers.next.answer == 'Yes' rescue false

            #Step 16   Legal Custody
            step = steps.next
            @legal_custody_parent = Array.new
            legal_custody_amount = @same_legal_custody ? 1 : @number_of_children

            legal_custody_amount.times do |item_number|
              answers = step_answers_enum step, item_number
              _legal_custody = Array.new
              answers.next
              _legal_custody << answers.next.answer
              answers.next
              _legal_custody << answers.next.answer
              @legal_custody_parent.push _legal_custody
            end


            #Step 17   Legal Custody
            answers = step_answers_enum steps.next
            @same_physical_custody = answers.next.answer == 'Yes' rescue false

            #Step 18   Physical Custody
            step = steps.next

            @physical_custody_parent = Array.new
            physical_custody_amount = @same_physical_custody ? 1 : @number_of_children

            physical_custody_amount.times do |i|
              answers = step_answers_enum step, i
              physical_custody = Hash.new

              physical_custody[:number] = i
              physical_custody[:child] = get_headed_info answers.next, i
              answers.next
              answers.next
              physical_custody[:custody] = answers.next.answer

              if physical_custody[:custody] == "With #{ @plaintiff_full_name } and visits with #{ @defendant_full_name }" || physical_custody[:custody] == "With #{ @defendant_full_name } and visit with #{ @plaintiff_full_name }"
                answers.next
                33.times do answers.next end if physical_custody[:custody] == "With #{ @defendant_full_name } and visit with #{ @plaintiff_full_name }"
                selected_answers = Array.new
                4.times do
                  answer = answers.next
                  selected_answers.push answer.template_field.name.split(' /<spain/>').first if answer.answer == '1'
                end
                7.times do
                  answer = answers.next
                  if answer.answer == '1'
                    tmp_string = 'from ' + answer.template_field.name.split(' /<spain/>').first + ' ' + answers.next.answer
                    tmp_string += ', to ' + answers.next.answer + ' ' + answers.next.answer
                    selected_answers.push tmp_string
                  else
                    3.times do answers.next end
                  end
                end
              elsif physical_custody[:custody] == 'Both Parents'
                67.times do answers.next end
                selected_answers = Array.new

                2.times do
                  answer = answers.next
                  selected_answers.push answer.template_field.name.split(' /<spain/>').first if answer.answer == '1'
                end
                7.times do
                  answer = answers.next
                  if answer.answer == '1'
                    tmp_string = 'from ' + answer.template_field.name.split(' /<spain/>').first + ' with ' + answers.next.answer + ' ' + answers.next.answer
                    tmp_string += ', to ' + answers.next.answer + ' ' + answers.next.answer
                    selected_answers.push tmp_string
                  else
                    4.times do answers.next end
                  end
                end
              end
              selected_answers.each do |answer|
                answer.gsub!('<plaintiff_full_name>', @plaintiff_full_name)
                answer.gsub!('<defendant_full_name>', @defendant_full_name)
              end

              physical_custody[:answers] = selected_answers
              @physical_custody_parent.push physical_custody
            end

            #Step 19   Holiday
            @all_holidays = Array.new

            answers = step_answers_enum steps.next

            #Step 20   Holiday
            @holiday_now = answers.next.answer == 'Yes'
            if @number_of_children == 1
              holidays_amount = 1
            elsif @holiday_now
              answers.next
              same_schedule = answers.next.answer == 'Yes'
              holidays_amount = same_schedule ? 1 : @number_of_children
            end

            if !@holiday_now
              2.times do steps.next end
            else
              step = steps.next

              holidays_amount.times do |i|
                answers = step_answers_enum step, i

                holidays = Array.new
                child_holidays = Hash.new

                answer = answers.next
                child_holidays[:child] = get_headed_info(answer, i) if holidays_amount > 1

                7.times do
                  holiday = Array.new

                  holiday.push answers.next

                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer

                  if holiday[0].answer == '1'
                    holidays.push holiday
                  end
                end

                #Father and mother days, haven't who
                4.times do |i|
                  holiday = Array.new
                  holiday.push answers.next

                  holiday.push answers.next.answer
                  holiday.push answers.next.answer

                  if i > 1
                    holiday.push 'with Dad, every year'
                  else
                    holiday.push 'with Mom, every year'
                  end

                  if holiday[0].answer == '1'
                    holidays.push holiday
                  end
                end


                if holidays.length > 0

                  child_holidays[:holidays] = holidays
                  @all_holidays.push child_holidays
                end
              end

              #Step 21  More holiday
              step = steps.next

              holidays_amount.times do |i|
                answers = step_answers_enum step, i

                holidays = Array.new
                child_holidays = Hash.new

                answer = answers.next
                child_holidays[:child] = get_headed_info(answer, i) if holidays_amount > 1

                10.times do
                  holiday = Array.new
                  holiday.push answers.next
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer

                  if holiday[0].answer == '1'
                    holidays.push holiday
                  end
                end

                #Father and mother days, havent who
                2.times do |i|
                  holiday = Array.new
                  holiday.push answers.next
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  if i == 0
                    holiday.push 'with Dad, every year'
                  else
                    holiday.push 'with Mom, every year'
                  end

                  if holiday[0].answer == '1'
                    holidays.push holiday
                  end
                end

                3.times do
                  holiday = Array.new
                  holiday.push answers.next
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer

                  if holiday[0].answer == '1'
                    holidays.push holiday
                  end
                end

                #Holidays have no time
                3.times do
                  holiday = Array.new
                  holiday.push answers.next
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer
                  holiday.push answers.next.answer

                  if holiday[0].answer == '1'
                    holidays.push holiday
                  end
                end

                holiday = Array.new
                holiday.push answers.next
                holiday.push answers.next.answer
                holiday.push answers.next.answer
                holiday.push answers.next.answer
                holiday.push answers.next.answer
                holiday.push answers.next.answer
                holiday.push answers.next.answer

                if holiday[0].answer == '1'
                  holidays.push holiday
                end

                child_holidays[:holidays] = holidays
                if @all_holidays.select{ |h| h[:child] == child_holidays[:child] }.present?
                  @all_holidays.select{ |h| h[:child] == child_holidays[:child] }.first[:holidays].concat child_holidays[:holidays]
                else
                  @all_holidays.push child_holidays
                end
              end
            end

            #Step 22   Children’s Health Insurance
            answers = step_answers_enum steps.next
            @child_insurance = answers.next.answer

            #Step 23   Child Support Sole/Primary
            if @physical_custody_parent.select { |each_child| each_child[:custody] =~ /With|Only/}.empty?
              steps.next
            else
              @sole_primary_children_count = @physical_custody_parent.select { |each_child| each_child[:custody] =~ /With|Only/}.count
              answers = step_answers_enum steps.next
              @child_suport_who = answers.next.answer
              answers.next
              @how_pay = answers.next.answer
              answers.next
              @child_suport_amount = answers.next.answer
            end

            #Step 24   Child Support Joint
            if @physical_custody_parent.select { |each_child| each_child[:custody] =~ /Both/}.empty?
              steps.next
            else
              @joint_children_count = @physical_custody_parent.select { |each_child| each_child[:custody] =~ /Both/}.count
              answers = step_answers_enum steps.next
              answers.next
              answers.next
              @mom_month_amount = answers.next.answer
              @dad_month_amount = answers.next.answer
            end

            #Step 25 Additional Child Support
            answers = step_answers_enum steps.next
            answers.next
            @plaintiff_employed_presence = answers.next.answer == 'Yes' rescue false
            if @plaintiff_employed_presence
              @plaintiff_employer_name = answers.next.answer
              @plaintiff_business_address = answers.next.answer.titleize
              @plaintiff_employer_city = answers.next.answer.classify
              @plaintiff_employer_state = answers.next.answer.classify
              @plaintiff_employer_zip = answers.next.answer.classify
              @plaintiff_employer_phone = answers.next.answer
              @plaintiff_drivers_license = answers.next.answer
            else
              7.times do answers.next end
            end
            answers.next
            @plaintiff_ethnicity = answers.next.answer

            #Step 26 Additional Child Support For Spouse
            answers = step_answers_enum steps.next
            answers.next
            @defendant_employed_presence = answers.next.answer == 'Yes' rescue false
            if @defendant_employed_presence
              @defendant_employer_name = answers.next.answer
              @defendant_business_address = answers.next.answer.titleize
              @defendant_employer_city = answers.next.answer.classify
              @defendant_employer_state = answers.next.answer.classify
              @defendant_employer_zip = answers.next.answer.classify
              @defendant_employer_phone = answers.next.answer
              @defendant_drivers_license = answers.next.answer
            else
              7.times do answers.next end
            end
            answers.next
            @defendant_ethnicity = answers.next.answer

            #Step 27  Wage withholding
            answers = step_answers_enum steps.next
            answers.next.answer
            @request_withhold = answers.next.answer

            #Step 28   Child  Support Arrears
            answers = step_answers_enum steps.next
            answers.next
            answers.next
            @request_arrears = answers.next.answer == 'Yes' rescue false
            @request_arrears_from = answers.next.answer.to_s.gsub(/\/[0-9]{1,2}\//, '/')
            answers.next
            @request_amount_paid = answers.next.answer

            #Step 29   Child Tax Exemption
            step = steps.next
            @child_tax_examption = Array.new

            @number_of_children.times do |i|
              answers = step_answers_enum step, i
              answers.next.answer
              @child_tax_examption.push [answers.next.answer, i, answers.next.answer]
            end
          end
        end

        #Step 30   Pet
        answers = step_answers_enum steps.next
        @pet_presence = answers.next.answer == 'Yes' rescue false
        @pet_amount = answers.next.answer.to_i rescue 0

        if !@pet_presence
          steps.next
        else

          #Step 31  Pet custody
          step = steps.next

          @pets = Array.new
          @pet_amount.times do |i|

            answers = step_answers_enum step, i
            pet = Array.new

            pet.push 'pet'
            pet.push answers.next.answer
            pet.push answers.next.answer
            @pets.push pet
          end
        end

        #Step 32   Property
        answers = step_answers_enum steps.next
        answers.next
        @property_presence = answers.next.answer
        if @property_presence != 'Yes'
          5.times do steps.next end
        else

          @properties_more = Array.new

          #Step 33  Property Division: Marital Home
          answers = document.step_answers steps.next

          if @property_presence

            house = answers.select{ |item| item.sort_index == 'a' }
            house.sort_by!{ |item| item.sort_number }
            if house.first.answer == '1'
              loop_answer = house.second.answer.to_i
              loop_answer.times do
                house.shift 2
                @properties_more.push ['House', house.first.answer, house.second.answer]
              end
            end

            land = answers.select{ |item| item.sort_index == 'c' }
            land.sort_by!{ |item| item.sort_number }
            if land.first.answer == '1'
              loop_answer = land.second.answer.to_i
              loop_answer.times do
                land.shift 2
                @properties_more.push ['Land', land.first.answer, land.second.answer]
              end
            end

            business = answers.select{ |item| item.sort_index == 'e' }
            business.sort_by!{ |item| item.sort_number }
            if business.first.answer == '1'
              loop_answer = business.second.answer.to_i
              business.shift 2
              loop_answer.times do
                @properties_more.push ['Business', business.first.answer, business.second.answer, business.third.answer]
                business.shift 3
              end
            end
          end

          #Step 35  Property Division: Vehicles
          answers = document.step_answers steps.next

          car = answers.select{ |item| item.sort_index == 'a' }
          car.sort_by!{ |item| item.sort_number }
          if car.first.answer == '1'
            loop_answer = car.second.answer.to_i
            loop_answer.times do
              car.shift 2
              @properties_more.push ['Car', car.first.answer, car.second.answer]
            end
          end

          motorcycle = answers.select{ |item| item.sort_index == 'c' }
          motorcycle.sort_by!{ |item| item.sort_number }
          if motorcycle.first.answer == '1'
            loop_answer = motorcycle.second.answer.to_i
            loop_answer.times do
              motorcycle.shift 2
              @properties_more.push ['Motorcycle', motorcycle.first.answer, motorcycle.second.answer]
            end
          end

          rv = answers.select{ |item| item.sort_index == 'e' }
          rv.sort_by!{ |item| item.sort_number }
          if rv.first.answer == '1'
            loop_answer = rv.second.answer.to_i
            loop_answer.times do
              rv.shift 2
              @properties_more.push ['RV', rv.first.answer, rv.second.answer]
            end
          end

          boat = answers.select{ |item| item.sort_index == 'g' }
          boat.sort_by!{ |item| item.sort_number }
          if boat.first.answer == '1'
            loop_answer = boat.second.answer.to_i
            loop_answer.times do
              boat.shift 2
              @properties_more.push ['Boat', boat.first.answer, boat.second.answer]
            end
          end

          trailer = answers.select{ |item| item.sort_index == 'i' }
          trailer.sort_by!{ |item| item.sort_number }
          if trailer.first.answer == '1'
            loop_answer = trailer.second.answer.to_i
            loop_answer.times do
              trailer.shift 2
              @properties_more.push ['Trailer', trailer.first.answer, trailer.second.answer]
            end
          end

          other = answers.select{ |item| item.sort_index == 'k' }
          other.sort_by!{ |item| item.sort_number }
          if other.first.answer == '1'
            loop_answer = other.second.answer.to_i
            loop_answer.times do
              other.shift 2
              @properties_more.push ['Other', other.first.answer, other.second.answer]
            end
          end

          #Step 36   Property Division: Pension Benefit
          @debts_accounts = Array.new
          answers = document.step_answers steps.next

          plan = answers.select{ |item| item.sort_index == 'a' }
          plan.sort_by!{ |item| item.sort_number }
          if plan.first.answer == 'Yes'
            loop_answer = plan.second.answer.to_i
            loop_answer.times do
              plan.shift 2
              @debts_accounts.push ['Retirement', plan.first.answer, plan.second.answer]
            end
          end

          #Step 37   Property Division: Bank and Investment Account
          @bank_account = Array.new
          answers = document.step_answers steps.next

          bank = answers.select{ |item| item.sort_index == 'a' }
          bank.sort_by!{ |item| item.sort_number }
          if bank.first.answer == 'Yes'
            loop_answer = bank.second.answer.to_i
            bank.shift 2
            loop_answer.times do
              @bank_account.push ['Account', bank.first.answer, bank.second.answer, bank.third.answer, bank.fourth.answer]
              bank.shift 4
            end
          end

          #Step 38   Property Division: Other
          answers = document.step_answers steps.next
          @other_properties = Array.new
          other_property = answers.select{ |item| item.sort_index == 'a' }
          other_property.sort_by!{ |item| item.sort_number }
          if other_property.first.answer == '1'
            loop_answer = other_property.second.answer.to_i
            loop_answer.times do
              other_property.shift 2
              @other_properties.push ['Other', other_property.first.answer, other_property.second.answer]
            end
          end
        end

        #Step 39   Debts
        answers = document.step_answers steps.next
        @community_debts = answers.last.answer
        @debt_devision = Array.new

        if @community_debts == 'Yes'
          #Step 40 Debts Division
          answers = document.step_answers steps.next

          house = answers.select{ |item| item.sort_index == 'a' }
          house.sort_by!{ |item| item.sort_number }
          if house.first.answer == '1'
            tmp_house = house.first
            loop_answer = house.second.answer.to_i
            house.shift 2
            loop_answer.times do
              @debt_devision.push ['House', house.first.answer, house.second.answer, house.third.answer]
              house.shift 3
            end
          end

          land = answers.select{ |item| item.sort_index == 'b' }
          land.sort_by!{ |item| item.sort_number }
          if land.first.answer == '1'
            tmp_land = land.first
            loop_answer = land.second.answer.to_i
            land.shift 2
            loop_answer.times do
              @debt_devision.push ['Land', land.first.answer, land.second.answer, land.third.answer]
              land.shift 3
            end
          end

          #Step 41
          answers = document.step_answers steps.next

          card = answers.select{ |item| item.sort_index == 'a' }
          card.sort_by!{ |item| item.sort_number }
          if card.first.answer == '1'
            loop_answer = card.second.answer.to_i
            loop_answer.times do
              card.shift 2
              @debt_devision.push ['Credit Cards', card.first.answer, card.second.answer]
            end
          end

          hospital = answers.select{ |item| item.sort_index == 'b' }
          hospital.sort_by!{ |item| item.sort_number }
          if hospital.first.answer == '1'
            loop_answer = hospital.second.answer.to_i
            loop_answer.times do
              hospital.shift 2
              @debt_devision.push ['Hospital bills', hospital.first.answer, hospital.second.answer]
            end
          end

          doctor = answers.select{ |item| item.sort_index == 'c' }
          doctor.sort_by!{ |item| item.sort_number }
          if doctor.first.answer == '1'
            loop_answer = doctor.second.answer.to_i
            loop_answer.times do
              doctor.shift 2
              @debt_devision.push ['Doctor bills', doctor.first.answer, doctor.second.answer]
            end
          end

          #Step 42
          answers = document.step_answers steps.next

          car = answers.select{ |item| item.sort_index == 'a' }
          car.sort_by!{ |item| item.sort_number }
          if car.first.answer == '1'
            loop_answer = car.second.answer.to_i
            loop_answer.times do
              car.shift 2
              @debt_devision.push ['Car', car.first.answer, car.second.answer]
            end
          end

          rv = answers.select{ |item| item.sort_index == 'b' }
          rv.sort_by!{ |item| item.sort_number }
          if rv.first.answer == '1'
            loop_answer = rv.second.answer.to_i
            loop_answer.times do
              rv.shift 2
              @debt_devision.push ['RV', rv.first.answer, rv.second.answer]
            end
          end

          boat = answers.select{ |item| item.sort_index == 'c' }
          boat.sort_by!{ |item| item.sort_number }
          if boat.first.answer == '1'
            loop_answer = boat.second.answer.to_i
            loop_answer.times do
              boat.shift 2
              @debt_devision.push ['Boat', boat.first.answer, boat.second.answer]
            end
          end

          motorcycle = answers.select{ |item| item.sort_index == 'd' }
          motorcycle.sort_by!{ |item| item.sort_number }
          if motorcycle.first.answer == '1'
            loop_answer = motorcycle.second.answer.to_i
            loop_answer.times do
              motorcycle.shift 2
              @debt_devision.push ['Motorcycle', motorcycle.first.answer, motorcycle.second.answer]
            end
          end

          #Step 43
          answers = document.step_answers steps.next

          student = answers.select{ |item| item.sort_index == 'a' }
          student.sort_by!{ |item| item.sort_number }
          if student.first.answer == '1'
            loop_answer = student.second.answer.to_i
            loop_answer.times do
              student.shift 2
              @debt_devision.push ['Student loan', student.first.answer, student.second.answer]
            end
          end

          irs = answers.select{ |item| item.sort_index == 'b' }
          irs.sort_by!{ |item| item.sort_number }
          if irs.first.answer == '1'
            loop_answer = irs.second.answer.to_i
            loop_answer.times do
              irs.shift 2
              @debt_devision.push ['IRS', irs.first.answer, irs.second.answer]
            end
          end

          payday = answers.select{ |item| item.sort_index == 'c' }
          payday.sort_by!{ |item| item.sort_number }
          if payday.first.answer == '1'
            loop_answer = payday.second.answer.to_i
            loop_answer.times do
              payday.shift 2
              @debt_devision.push ['Payday loan', payday.first.answer, payday.second.answer]
            end
          end

          other_loan = answers.select{ |item| item.sort_index == 'd' }
          other_loan.sort_by!{ |item| item.sort_number }
          if other_loan.first.answer == '1'
            loop_answer = other_loan.second.answer.to_i
            loop_answer.times do
              other_loan.shift 2
              @debt_devision.push ['Other loan', other_loan.first.answer, other_loan.second.answer]
            end
          end

          #Step 44
          answers = document.step_answers steps.next

          other_debt = answers.select{ |item| item.sort_index == 'a' }
          other_debt.sort_by!{ |item| item.sort_number }
          if other_debt.first.answer == '1'
            loop_answer = other_debt.second.answer.to_i
            loop_answer.times do
              other_debt.shift 2
              @debt_devision.push ['Other debt', other_debt.first.answer, other_debt.second.answer]
            end
          end
        else
          5.times do steps.next end
        end

        #Step 45   Spousal support or Alimony
        answers = step_answers_enum steps.next
        @alimony_presence = answers.next.answer == 'Yes' rescue false
        if @alimony_presence

          @alimony_who = answers.next.answer
          @alimony_how_much = answers.next.answer
          @alimony_how_long = answers.next.answer
          @alimony_year_month = answers.next.answer

          if @alimony_year_month =~ /Year/
            if @alimony_how_long == '1'
              @alimony_year_month = 'year'
            else
              @alimony_year_month = 'years'
            end
          else
            if @alimony_how_long == '1'
              @alimony_year_month = 'month'
            else
              @alimony_year_month = 'months'
            end
          end
          answers.next
          @affidavit_of_support = answers.next.answer == 'Yes' rescue false
        end

        #Step 46   Wife’s Name
        answers = step_answers_enum steps.next

        @wife_name_changing = answers.next.answer
        @wife_name = answers.next.answer

        #Step 47   Reason divorce
        answers = step_answers_enum steps.next
        @reason_divorce = answers.next.answer

        #Step 48_JOINT Resident witness
        if @packet == 'Joint Petition'
          answers = step_answers_enum steps.next
          @witness = {}
          @witness[:first_name] = answers.next.answer
          @witness[:middle_name] = answers.next.answer
          @witness[:last_name] = answers.next.answer
          @witness[:full_name] = "#{ @witness[:first_name] } #{ @witness[:middle_name] } #{ @witness[:last_name] }".squish
          @witness[:address] = answers.next.answer
          @witness[:city] = answers.next.answer
          @witness[:state] = answers.next.answer
          @witness[:zip] = answers.next.answer
          answers.next
          @witness[:relationship] = answers.next.answer
          @witness[:relationship] =~ /Other/ ? @witness[:relationship] = answers.next.answer : answers.next
          @witness[:meet_date] = answers.next.answer.to_date
          answers.next
          @witness[:see_times] = answers.next.answer
          @witness[:moved_date] = answers.next.answer.to_date
        else
          steps.next
        end

        #Step 49 DOMESTIC VIOLENCE
        answers = step_answers_enum steps.next
        @domestic_violence = answers.next.answer == 'Yes' rescue false
        answers.next
        @temporary_protective_order = answers.next.answer == 'Yes' rescue false
        @temporary_protective_order_case = answers.next.answer
        answers.next
        @show_in_complaint = answers.next.answer == 'Yes' rescue false

        #Step 50 COURT COST AND ATTORNEY’S FEES
        answers = step_answers_enum steps.next
        @court_cost_attorney_fees = answers.next.answer == 'Yes' rescue false

        #Step 51 Other cases in Family court
        answers = step_answers_enum steps.next
        @family_court = answers.next.answer == 'Yes' rescue false

        #Step 52 Other cases in Family court
        if @family_court
          answers = document.step_answers steps.next
          @child_array = Array.new
          answers.sort_by!{ |item| item.template_field_id } rescue nil

          array_index = 0
          @divorce = answers[array_index].answer == '1' rescue false
          if @divorce
            @divorce_array = Array.new
            array_index += 1
            3.times do
              @divorce_array.push answers[array_index += 1].answer
            end
            array_index += 1
            5.times do
              @divorce_array.push answers[array_index += 1].answer
            end
          else
            array_index += 10
          end

          @tpo = answers[array_index += 1].answer == '1' rescue false
          if @tpo
            @tpo_array = Array.new
            array_index += 1
            3.times do
              @tpo_array.push answers[array_index += 1].answer
            end
            [array_index += 1]
            5.times do
              @tpo_array.push answers[array_index += 1].answer
            end
          else
            array_index += 10
          end

          @custody_support = answers[array_index += 1].answer == '1' rescue false
          if @custody_support
            @custody_support_array = Array.new
            array_index += 1
            3.times do
              @custody_support_array.push answers[array_index += 1].answer
            end
            array_index += 1
            5.times do
              @custody_support_array.push answers[array_index += 1].answer
            end
            array_index += 2
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
            array_index += 1
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
          else
            array_index += 25
          end

          @paternity = answers[array_index += 1].answer == '1' rescue false
          if @paternity
            @paternity_array = Array.new
            array_index += 1
            3.times do
              @paternity_array.push answers[array_index += 1].answer
            end
            array_index += 1
            5.times do
              @paternity_array.push answers[array_index += 1].answer
            end
            array_index += 2
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
            array_index += 1
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
          else
            array_index += 25
          end

          @juvenile_court = answers[array_index += 1].answer == '1' rescue false
          if @juvenile_court
            @juvenile_court_array = Array.new
            array_index += 1
            3.times do
              @juvenile_court_array.push answers[array_index += 1].answer
            end
            array_index += 1
            5.times do
              @juvenile_court_array.push answers[array_index += 1].answer
            end
            array_index += 2
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
            array_index += 1
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
          else
            array_index += 25
          end

          @guardianship = answers[array_index += 1].answer == '1' rescue false
          if @guardianship
            @guardianship_array = Array.new
            array_index += 1
            3.times do
              @guardianship_array.push answers[array_index += 1].answer
            end
            array_index += 1
            5.times do
              @guardianship_array.push answers[array_index += 1].answer
            end
          else
            array_index += 10
          end

          @termination_parental_right = answers[array_index += 1].answer == '1' rescue false
          if @termination_parental_right
            @termination_parental_right_array = Array.new
            array_index += 1
            3.times do
              @termination_parental_right_array.push answers[array_index += 1].answer
            end
            [array_index += 1]
            5.times do
              @termination_parental_right_array.push answers[array_index += 1].answer
            end
            array_index += 2
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
            array_index += 1
            6.times do
              @child_array.push answers[array_index += 1].answer
            end
          else
            array_index += 25
          end
        end
    end
  end
end
module PdfDocument
  class DivorceWrapper < Wrapper
    def initialize(document)

      @header_margin_top = 40
      @text_indent = 20

      @document_id = document.id
      @data_array = Array.new

      #Step zero
      steps = document.template.steps.to_enum
      answers = step_answers_enum steps.next
      @clark_nye = answers.next.answer.strip

      #First step   Your information
      answers = step_answers_enum steps.next

      @plaintiff_first_name = answers.next.answer
      @plaintiff_middle_name = answers.next.answer
      @plaintiff_last_name = answers.next.answer

      @plaintiff_date_of_birth = answers.next.answer
      @plaintiff_social_security = answers.next.answer
      @plaintiff_mailing_addres = answers.next.answer
      @plaintiff_city = answers.next.answer
      @plaintiff_state = answers.next.answer
      @plaintiff_zip = answers.next.answer
      @plaintiff_phone = answers.next.answer
      @plaintiff_email = answers.next.answer
      @plaintiff_wife_husband = answers.next.answer

      @mom = @plaintiff_wife_husband == 'I am Wife' ? 'plaintiff' : 'defendant'
      @dad = @plaintiff_wife_husband == 'I am Wife' ? 'defendant' : 'plaintiff'

      #Second step   Your Spouse\'s Information
      answers = step_answers_enum steps.next

      @defendant_first_name = answers.next.answer
      @defendant_middle_name = answers.next.answer
      @defendant_last_name = answers.next.answer
      @defendant_date_of_birth = answers.next.answer
      @defendant_social_security = answers.next.answer
      @defendant_mailing_address = answers.next.answer
      @defendant_city = answers.next.answer
      @defendant_state = answers.next.answer
      @defendant_zip = answers.next.answer

      @defendant_email = answers.next.answer
      @defendant_phone = answers.next.answer

      #Step 3   Marriage Information
      answers = step_answers_enum steps.next

      @in_the_us = answers.next.answer == 'In the United States'
      @marriage_city = answers.next.answer
      @marriage_state = answers.next.answer

      @marriage_city_town_province = answers.next.answer
      @marriage_country = answers.next.answer
      @marriage_date = answers.next.answer

      @marriage_country_string = "in the city of #{ @in_the_us ? @marriage_city : @marriage_city_town_province }"
      @marriage_country_string += @in_the_us ? " State of #{ @marriage_state }" : " Country of #{ @marriage_country }"
      @marriage_country_string += ' and have since remained husband and wife.'


      @marriage_country_string_short = "#{ @in_the_us ? @marriage_city : @marriage_city_town_province }"
      @marriage_country_string_short += @in_the_us ? " State of #{ @marriage_state }" : " Country of #{ @marriage_country }"

      #Step 4   Nevada Residency
      answers = step_answers_enum steps.next

      @lived_in_nevada_since = answers.next.answer

      #Step 5   Pregnacy
      answers = step_answers_enum steps.next
      @wife_pregnacy = answers.next.answer == 'IS currently pregnant'

      #Step 6   Children
      answers = step_answers_enum steps.next
      @children_adopted = answers.next.answer == 'Yes' rescue false
      #NOTICE: 7 merged with 6
      #Step 7   Children's Residency
      answers.next
      @children_residency = answers.next.answer == 'Yes' rescue false

      if !@children_residency

        11.times do steps.next end
      else

        #Step 8   Number of children
        answers = step_answers_enum steps.next
        answers.next.answer
        @number_of_children = answers.next.answer.to_i

        #Step 9   Child(ren)'s Information
        step = steps.next
        @children_info = Array.new

        @number_of_children.times do |i|

          answers = step_answers_enum step, i
          child_info = Hash.new
          child_info[:first_name] = answers.next.answer
          child_info[:middle_name] = answers.next.answer
          child_info[:last_name] = answers.next.answer
          child_info[:date_of_birth] = answers.next.answer
          child_info[:social_security] = answers.next.answer
          child_info[:is_son] = answers.next.answer == 'Son'

          @children_info.push child_info
        end

        #Step 10   Legal Custody
        answers = step_answers_enum steps.next
        @legal_custody_parent = answers.next.answer

        #Step 11   Physical Custody
        step = steps.next
        @physical_custody_parent = Array.new

        @number_of_children.times do |i|
          answers = step_answers_enum step, i

          physical_custody = Hash.new

          physical_custody[:child] = get_headed_info answers.next, i
          answers.next
          physical_custody[:custody] = answers.next.answer

          @physical_custody_parent.push physical_custody
        end

        #Step 12   Holiday
        @all_holidays = Array.new

        step = steps.next
        @number_of_children.times do |i|
          answers = step_answers_enum step, i

          holidays = Array.new
          child_holidays = Hash.new

          child_holidays[:child] = get_headed_info answers.next, i

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
          4.times do
            holiday = Array.new
            holiday.push answers.next

            holiday.push answers.next.answer
            holiday.push answers.next.answer

            if holiday[0].answer == '1'
              holidays.push holiday
            end
          end

          if holidays.length > 0
            child_holidays[:holidays] = holidays
            @all_holidays.push child_holidays
          end
        end

        #Step 13   More holiday
        step = steps.next
        @number_of_children.times do |i|
          answers = step_answers_enum step, i

          holidays = Array.new
          child_holidays = Hash.new

          child_holidays[:child] = get_headed_info answers.next, i

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
          2.times do
            holiday = Array.new
            holiday.push answers.next
            holiday.push answers.next.answer
            holiday.push answers.next.answer

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

        #Step 14   Children’s Health Insurance
        answers = step_answers_enum steps.next
        @child_insurance = answers.next.answer

        #Step 15   Child Support
        answers = step_answers_enum steps.next
        @child_suport_who = answers.next.answer
        @child_suport_amount = answers.next.answer

        #Step 16   Wage withholding
        answers = step_answers_enum steps.next
        answers.next.answer
        @request_withhold = answers.next.answer == 'Yes' rescue false

        #Step 17   Child  Support Arrears
        answers = step_answers_enum steps.next
        answers.next
        answers.next
        @request_arrears = answers.next.answer == 'Yes' rescue false
        @request_arrears_from = answers.next.answer
        answers.next
        @request_amount_paid = answers.next.answer

        #Step 18   Child Tax Exemption
        step = steps.next
        @child_tax_examption = Array.new

        @number_of_children.times do |i|
          answers = step_answers_enum step, i

          @child_tax_examption.push [ answers.next.answer, answers.next.answer ]
        end
      end

      #Step 19   Pet
      answers = step_answers_enum steps.next
      @pet_presence = answers.next.answer == 'Yes' rescue false
      @pet_amount = answers.next.answer.to_i rescue 0

      if !@pet_presence
        steps.next
      else

        #Step 20   Pet custody
        step = steps.next

        @pets = Array.new
        @pet_amount.times do |i|

          answers = step_answers_enum step, i
          pet = Array.new

          pet.push answers.next.answer
          pet.push answers.next.answer
          @pets.push pet
        end
      end

      #Step 21   Property
      answers = step_answers_enum steps.next
      answers.next
      @property_presence = answers.next.answer

      if @property_presence != 'Yes'

        8.times do steps.next end
      else

        #Step 22   Property Division: Marital Home
        answers = step_answers_enum steps.next
        @property_marital_presence = answers.next.answer == 'Yes' rescue false
        @property_marital_address = answers.next.answer
        @property_marital_who = answers.next.answer
        answers.next
        @property_presence_more = answers.next.answer == 'Yes' rescue false

        @properties_more = Array.new

        #Step 23   Property Division: Marital Home
        answers = document.step_answers steps.next

        if @property_presence_more

          house = answers.select{ |item| item.sort_index == 'a' }
          house.sort_by!{ |item| item.sort_number }
          if house.first.answer == '1'
            tmp_house = house.first
            loop_answer = house.second.answer.to_i
            loop_answer.times do
              house.shift 2
              @properties_more.push [tmp_house, house.first, house.second]
            end
          end

          land = answers.select{ |item| item.sort_index == 'b' }
          land.sort_by!{ |item| item.sort_number }
          if land.first.answer == '1'
            tmp_land = land.first
            loop_answer = land.second.answer.to_i
            loop_answer.times do
              land.shift 2
              @properties_more.push [tmp_land, land.first, land.second]
            end
          end

          business = answers.select{ |item| item.sort_index == 'c' }
          business.sort_by!{ |item| item.sort_number }
          if business.first.answer == '1'
            tmp_business = business.first
            loop_answer = business.second.answer.to_i
            business.shift 2
            loop_answer.times do
              @properties_more.push [tmp_business, business.first, business.second, business.third]
              business.shift 3
            end
          end
        end

        #Step 24   Property Division: Vehicles
        answers = step_answers_enum steps.next
        @vehicles_presence = answers.next.answer == 'Yes' rescue false

        #Step 25   Property Division: Vehicles
        answers = document.step_answers steps.next
        if @vehicles_presence

          car = answers.select{ |item| item.sort_index == 'a' }
          car.sort_by!{ |item| item.sort_number }
          if car.first.answer == '1'
            tmp_car = car.first
            loop_answer = car.second.answer.to_i
            loop_answer.times do
              car.shift 2
              @properties_more.push [tmp_car, car.first, car.second]
            end
          end

          motorcycle = answers.select{ |item| item.sort_index == 'b' }
          motorcycle.sort_by!{ |item| item.sort_number }
          if motorcycle.first.answer == '1'
            tmp_motorcycle = motorcycle.first
            loop_answer = motorcycle.second.answer.to_i
            loop_answer.times do
              motorcycle.shift 2
              @properties_more.push [tmp_motorcycle, motorcycle.first, motorcycle.second]
            end
          end

          rv = answers.select{ |item| item.sort_index == 'c' }
          rv.sort_by!{ |item| item.sort_number }
          if rv.first.answer == '1'
            tmp_rv = rv.first
            loop_answer = rv.second.answer.to_i
            loop_answer.times do
              rv.shift 2
              @properties_more.push [tmp_rv, rv.first, rv.second]
            end
          end

          boat = answers.select{ |item| item.sort_index == 'd' }
          boat.sort_by!{ |item| item.sort_number }
          if boat.first.answer == '1'
            tmp_boat = boat.first
            loop_answer = boat.second.answer.to_i
            loop_answer.times do
              boat.shift 2
              @properties_more.push [tmp_boat, boat.first, boat.second]
            end
          end

          trailer = answers.select{ |item| item.sort_index == 'e' }
          trailer.sort_by!{ |item| item.sort_number }
          if trailer.first.answer == '1'
            tmp_trailer = trailer.first
            loop_answer = trailer.second.answer.to_i
            loop_answer.times do
              trailer.shift 2
              @properties_more.push [tmp_trailer, trailer.first, trailer.second]
            end
          end

          other = answers.select{ |item| item.sort_index == 'f' }
          other.sort_by!{ |item| item.sort_number }
          if other.first.answer == '1'
            tmp_other = other.first
            loop_answer = other.second.answer.to_i
            loop_answer.times do
              other.shift 2
              @properties_more.push [tmp_other, other.first, other.second]
            end
          end

        end

        #Step 26   Property Division: Pension Benefit
        @debts_accounts = Array.new
        answers = document.step_answers steps.next

        plan = answers.select{ |item| item.sort_index == 'a' }
        plan.sort_by!{ |item| item.sort_number }
        if plan.first.answer == 'Yes'
          tmp_plan = plan.first
          loop_answer = plan.second.answer.to_i
          loop_answer.times do
            plan.shift 2
            @debts_accounts.push [tmp_plan, plan.first, plan.second]
          end
        end

        #Step 27   Property Division: Bank and Investment Account
        @bank_account = Array.new
        answers = document.step_answers steps.next

        bank = answers.select{ |item| item.sort_index == 'a' }
        bank.sort_by!{ |item| item.sort_number }
        if bank.first.answer == 'Yes'
          tmp_bank = bank.first
          loop_answer = bank.second.answer.to_i
          bank.shift 2
          loop_answer.times do
            @bank_account.push [tmp_bank, bank.first, bank.second, bank.third, bank.fourth]
            bank.shift 4
          end
        end

        #Step 28   Property Division: Other
        answers = step_answers_enum steps.next
        @other_property_presence = answers.next.answer == 'Yes' rescue false

        #Step 29   Property Division: Other
        answers = step_answers_enum steps.next
        if @other_property_presence

          @other_properties = Array.new
          answers.each do |answer|
            @other_properties.push answer.template_field.to_s.split(' /<spain/>').first if answer.answer == '1'
          end
        end

      end

      #Step 30   Debts
      answers = document.step_answers steps.next
      @community_debts = answers.last.answer == 'Yes' rescue false

      if @community_debts
        #Step 31 Debts Division
        @debt_devision_accounts = Array.new
        answers = document.step_answers steps.next

        house = answers.select{ |item| item.sort_index == 'a' }
        house.sort_by!{ |item| item.sort_number }
        if house.first.answer == '1'
          tmp_house = house.first
          loop_answer = house.second.answer.to_i
          house.shift 2
          loop_answer.times do
            @debt_devision_accounts.push [tmp_house, house.first, house.second, house.third]
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
            @debt_devision_accounts.push [tmp_land, land.first, land.second, land.third]
            land.shift 3
          end
        end

        #Step 32
        @bill_accounts = Array.new
        answers = document.step_answers steps.next

        card = answers.select{ |item| item.sort_index == 'a' }
        card.sort_by!{ |item| item.sort_number }
        if card.first.answer == '1'
          tmp_card = card.first
          loop_answer = card.second.answer.to_i
          loop_answer.times do
            card.shift 2
            @bill_accounts.push [tmp_card, card.first, card.second]
          end
        end

        hospital = answers.select{ |item| item.sort_index == 'b' }
        hospital.sort_by!{ |item| item.sort_number }
        if hospital.first.answer == '1'
          tmp_hospital = hospital.first
          loop_answer = hospital.second.answer.to_i
          loop_answer.times do
            hospital.shift 2
            @bill_accounts.push [tmp_hospital, hospital.first, hospital.second]
          end
        end

        doctor = answers.select{ |item| item.sort_index == 'c' }
        doctor.sort_by!{ |item| item.sort_number }
        if doctor.first.answer == '1'
          tmp_doctor = doctor.first
          loop_answer = doctor.second.answer.to_i
          loop_answer.times do
            doctor.shift 2
            @bill_accounts.push [tmp_doctor, doctor.first, doctor.second]
          end
        end

        #Step 33
        @car_loan = Array.new
        answers = document.step_answers steps.next

        car = answers.select{ |item| item.sort_index == 'a' }
        car.sort_by!{ |item| item.sort_number }
        if car.first.answer == '1'
          tmp_car = car.first
          loop_answer = car.second.answer.to_i
          loop_answer.times do
            car.shift 2
            @car_loan.push [tmp_car, car.first, car.second]
          end
        end

        rv = answers.select{ |item| item.sort_index == 'b' }
        rv.sort_by!{ |item| item.sort_number }
        if rv.first.answer == '1'
          tmp_rv = rv.first
          loop_answer = rv.second.answer.to_i
          loop_answer.times do
            rv.shift 2
            @car_loan.push [tmp_rv, rv.first, rv.second]
          end
        end

        boat = answers.select{ |item| item.sort_index == 'c' }
        boat.sort_by!{ |item| item.sort_number }
        if boat.first.answer == '1'
          tmp_boat = boat.first
          loop_answer = boat.second.answer.to_i
          loop_answer.times do
            boat.shift 2
            @car_loan.push [tmp_boat, boat.first, boat.second]
          end
        end

        motorcycle = answers.select{ |item| item.sort_index == 'd' }
        motorcycle.sort_by!{ |item| item.sort_number }
        if motorcycle.first.answer == '1'
          tmp_motorcycle = motorcycle.first
          loop_answer = motorcycle.second.answer.to_i
          loop_answer.times do
            motorcycle.shift 2
            @car_loan.push [tmp_motorcycle, motorcycle.first, motorcycle.second]
          end
        end

        #Step 34
        @student_loan = Array.new
        answers = document.step_answers steps.next

        student = answers.select{ |item| item.sort_index == 'a' }
        student.sort_by!{ |item| item.sort_number }
        if student.first.answer == '1'
          tmp_student = student.first
          loop_answer = student.second.answer.to_i
          loop_answer.times do
            student.shift 2
            @student_loan.push [tmp_student, student.first, student.second]
          end
        end

        irs = answers.select{ |item| item.sort_index == 'b' }
        irs.sort_by!{ |item| item.sort_number }
        if irs.first.answer == '1'
          tmp_irs = irs.first
          loop_answer = irs.second.answer.to_i
          loop_answer.times do
            irs.shift 2
            @student_loan.push [tmp_irs, irs.first, irs.second]
          end
        end

        payday = answers.select{ |item| item.sort_index == 'c' }
        payday.sort_by!{ |item| item.sort_number }
        if payday.first.answer == '1'
          tmp_payday = payday.first
          loop_answer = payday.second.answer.to_i
          loop_answer.times do
            payday.shift 2
            @student_loan.push [tmp_payday, payday.first, payday.second]
          end
        end

        other_loan = answers.select{ |item| item.sort_index == 'd' }
        other_loan.sort_by!{ |item| item.sort_number }
        if other_loan.first.answer == '1'
          tmp_other_loan = other_loan.first
          loop_answer = other_loan.second.answer.to_i
          loop_answer.times do
            other_loan.shift 2
            @student_loan.push [tmp_other_loan, other_loan.first, other_loan.second]
          end
        end
      end
      1.times do steps.next end

      #Step 36   Spousal support or Alimony
      answers = step_answers_enum steps.next
      @alimony_presence = answers.next.answer == 'Yes' rescue false
      if @alimony_presence

        @alimony_who = answers.next.answer
        @alimony_how_much = answers.next.answer
        @alimony_how_long = answers.next.answer
        @alimony_year_month = answers.next.answer
      end

      #Step 37   Wife’s Name
      answers = step_answers_enum steps.next

      @wife_name_changing = answers.next.answer
      @wife_name = answers.next.answer

      #Step 38   Reason divorce
      answers = step_answers_enum steps.next
      @reason_divorce = answers.next.answer
    end
  end
end
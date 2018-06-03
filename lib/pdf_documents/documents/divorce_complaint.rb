module PdfDocument
  class DivorceComplaint < DivorceWrapper
    include DivorceComplaintHelper

    def can_generate?
      @packet =~ /Divorce/
    end

    def generate
      _counter = 0
      default_leading 5
      push_text "<b>COMD</b>", :style => :bold

      push_text @plaintiff_full_name
      push_text "#{ @plaintiff_mailing_address } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }"

      push_text @plaintiff_phone
      push_text @plaintiff_email
      push_text 'Plaintiff Self-Represented', :style => :bold

      move_down 20
      push_header "IN THE #{ @clark_nye == 'Clark' ? '8' : '5' }th JUDICIAL DISTRICT COURT OF THE"
      push_header "STATE OF NEVADA, IN AND FOR THE COUNTY OF #{ @clark_nye.upcase }"
      move_down 20

      default_leading 3
      push_text "#{ @plaintiff_full_name },", :inline_format => true
      push_text "Plaintiff,#{ ' '*61 }CASE NO.:"
      move_down 10
      push_text "vs.#{ ' '*71 }DEPT NO.:"
      move_down 10
      push_text "#{ @defendant_full_name },", :inline_format => true
      push_text 'Defendant.'

      default_leading 8
      move_down 30
      push_header "<b>COMPLAINT FOR DIVORCE</b>"

      push_text "COMES NOW Plaintiff, #{ @plaintiff_full_name }, in Proper Person, and files this Complaint for Divorce against the above Defendant, and alleges as follows:", @text_indent

      move_to_left "#{ _counter += 1 }.  RESIDENCY"
      push_text "That the Plaintiff  has been and continues to be an actual, bona fide resident of Nevada and has been actually physically present and domiciled in the State of Nevada for more than six (6) weeks prior to the filing of this action.", @text_indent

      move_to_left "#{ _counter += 1 }.  DATE OF MARRIAGE"
      push_text "That the parties were married on the #{ @marriage_date_decree } #{ @marriage_country_string }", @text_indent

      move_to_left "#{ _counter += 1 }.  CHILDREN’S INFORMATION"
      if @children_residency
        tmp_text = "That the parties have #{ @number_of_children } minor #{ @number_of_children > 1 ? 'children' : 'child' }. The name and date of birth:"

        @children_info.each do |child|
          tmp_text += " #{ child[:full_name] } born #{ child[:date_of_birth] }, "
        end
        tmp_text += " who #{ @number_of_children > 1 ? 'are' : 'is' } the issue of this marriage, and there are no other minor children adopted or otherwise."

        if @children_nevada_residency
          tmp_text += " That the minor #{ @number_of_children > 1 ? 'children are' : 'child is' } residents of the State of Nevada and #{ @number_of_children > 1 ? 'have' : 'has' } lived in this state for at least the past six (6) months. Nevada is the habitual residence of the #{ @number_of_children > 1 ? 'children' : 'child' }."
        else
          tmp_text += " That the minor #{ @number_of_children > 1 ? 'children are not' : 'child is not' } residents of the State of  Nevada and #{ @number_of_children > 1 ? 'have not' : 'has not' } lived in this state for at least the past six (6) months. . The #{ @number_of_children > 1 ? 'children are residents' : 'child is resident' } of the State of Nevada. This Court does not have the jurisdiction to enter orders regarding custody and visitation."
        end
        push_text tmp_text, @text_indent
      else
        if @spouses == 'Male and Female'
          push_text 'That the parties do not have minor children who are the issue of this marriage or were adopted.', @text_indent
        elsif @spouses == 'Female'
          push_text "That the wives in this case are not currently pregnant.", @text_indent
        end
      end

      if @spouses == 'Male and Female'
        tmp_text = "That the wife in this case #{ @pregnacy ? 'is' : 'is not' } currently pregnant."
        tmp_text += " Husband #{ @pregnacy_unborn ? 'is' : 'is not' } the father of the unborn child. The unborn child is due to be born on #{ @pregnacy_date }" if @pregnacy
        push_text tmp_text, @text_indent
      elsif @spouses == 'Female'
        push_text "That #{ @plaintiff_full_name } currently pregnant. The unborn child is due to be born on #{ @pregnacy_user_date }.", @text_indent if @pregnacy_user
        push_text "That #{ @defendant_full_name } currently pregnant. The unborn child is due to be born on #{ @pregnacy_spouse_date }.", @text_indent if @pregnacy_spouse
      end


      if @show_in_complaint
        move_to_left "#{ _counter += 1 }.  DOMESTIC VIOLENCE"
        push_text "That Plaintiff alleges Defendant has committed domestic violence against Plaintiff.", @text_indent
        push_text "Plaintiff has had or currently has a Temporary Protective Order against Defendant.", @text_indent if @temporary_protective_order
      end

      # if @number_of_children && @children_residency
      #   move_to_left "#{ _counter += 1 }.  MINOR CHILDREN RESIDENCY"
      #   if @children_nevada_residency
      #     push_text "That the minor #{ @number_of_children > 1 ? 'children are' : 'child is' } residents of the State of Nevada and #{ @number_of_children > 1 ? 'have' : 'has' } lived in this state for at least the past six (6) months. Nevada is the habitual residence of the #{ @number_of_children > 1 ? 'children' : 'child' } and this Court does have the jurisdiction to enter orders regarding custody and visitation", @text_indent
      #   else
      #     push_text "That the minor #{ @number_of_children > 1 ? 'children are' : 'child is' } not residents of the State of  Nevada and #{ @number_of_children > 1 ? 'have' : 'has' } not lived in this state for at least the past six (6) months. The #{ @number_of_children > 1 ? 'children are' : 'child is' } residents of the State of Nevada. This Court does not have the jurisdiction to enter orders regarding custody and visitation.", @text_indent
      #   end
      # end

      if @children_residency && @children_nevada_residency
        move_to_left "#{ _counter += 1 }.  LEGAL CUSTODY"

        @legal_custody_parent.each_with_index do |legal_custody, index|
          case legal_custody.first
          when 'BOTH Parents'
            if @same_legal_custody
              push_text "That both parties are fit and proper people to be awarded JOINT LEGAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
            else
              push_text "That both parties are fit and proper people to be awarded JOINT LEGAL custody of the minor #{ @children_info[index][:full_name] }.", @text_indent
            end
          when "Only #{ @plaintiff_full_name }"
            if @same_legal_custody
              push_text "The #{ @mom.capitalize } is a fit and proper person to be awarded SOLE LEGAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
            else
              push_text "The #{ @mom.capitalize } is a fit and proper person to be awarded SOLE LEGAL custody of the minor #{ @children_info[index][:full_name] }.", @text_indent
            end
          when "Only #{ @defendant_full_name }"
            if @same_legal_custody
              push_text "The #{ @dad.capitalize } is a fit and proper person to be awarded SOLE LEGAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
            else
              push_text "The #{ @dad.capitalize } is a fit and proper person to be awarded SOLE LEGAL custody of the minor #{ @children_info[index][:full_name] }.", @text_indent
            end
          end
          if @same_legal_custody
            push_text "Defendant should sign all paperwork necessary for the minor #{ @number_of_children > 1 ? 'children' : 'child' } to receive passport. ", @text_indent if legal_custody.second == 'Yes'
          else
            push_text "Defendant should sign all paperwork necessary for the minor #{ @children_info[index][:full_name] } to receive passport. ", @text_indent if legal_custody.second == 'Yes'
          end
        end

        move_to_left "#{ _counter += 1 }.  PHYSICAL CUSTODY"

        @physical_custody_parent.each_with_index do |physical_custody, index|
          case physical_custody[:custody]

          when /and visit/
            case physical_custody[:custody]

            when /^With #{ @plaintiff_full_name }/
              if @same_physical_custody
                push_text "That #{ @mom.capitalize } is a fit and proper person to be awarded PRIMARY PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' } with #{ @dad.capitalize } having visitation as follows:", @text_indent
                physical_custody[:answers].each_with_index do |answer, index|
                  push_text "#{ (97 + index).chr }. #{ answer }"
                end
              else
                push_text "That #{ @mom.capitalize } is a fit and proper person to be awarded PRIMARY PHYSICAL custody of the minor #{ @children_info[index][:full_name] } with #{ @dad.capitalize } having visitation as follows:", @text_indent
                physical_custody[:answers].each_with_index do |answer, index|
                  push_text "#{ (97 + index).chr }. #{ answer }"
                end
              end
            when /^With #{ @defendant_full_name }/
              if @same_physical_custody
                push_text "That #{ @dad.capitalize } is a fit and proper person to be awarded PRIMARY PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' } with #{ @mom.capitalize } having visitation as follows:", @text_indent
                physical_custody[:answers].each_with_index do |answer, index|
                  push_text "#{ (97 + index).chr }. #{ answer }"
                end
              else
                push_text "That #{ @dad.capitalize } is a fit and proper person to be awarded PRIMARY PHYSICAL custody of the minor #{ @children_info[index][:full_name] } with #{ @mom.capitalize } having visitation as follows:", @text_indent
                physical_custody[:answers].each_with_index do |answer, index|
                  push_text "#{ (97 + index).chr }. #{ answer }"
                end
              end
            end

          when /^Both/
            if @same_physical_custody
              push_text "That the parties are fit and proper person to be awarded JOINT PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' } and the parties’ timeshare should be as follows:", @text_indent
              physical_custody[:answers].each_with_index do |answer, index|
                push_text "#{ (97 + index).chr }. #{ answer }"
              end
            else
              push_text "That the parties are fit and proper person to be awarded JOINT PHYSICAL custody of the minor #{ @children_info[index][:full_name] } and the parties’ timeshare should be as follows:", @text_indent
              physical_custody[:answers].each_with_index do |answer, index|
                push_text "#{ (97 + index).chr }. #{ answer }"
              end
            end
          when /^Only/
            case physical_custody[:custody]
            when /#{ @plaintiff_full_name }/
              if @same_physical_custody
                push_text "That #{ @mom.capitalize } is a fit and proper person to be awarded SOLE PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
              else
                push_text "That #{ @mom.capitalize } is a fit and proper person to be awarded SOLE PHYSICAL custody of the minor #{ @children_info[index][:full_name] }.", @text_indent
              end
            when /#{ @defendant_full_name }/
              if @same_physical_custody
                push_text "That #{ @dad.capitalize } is a fit and proper person to be awarded SOLE PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
              else
                push_text "That #{ @dad.capitalize } is a fit and proper person to be awarded SOLE PHYSICAL custody of the minor #{ @children_info[index][:full_name] }.", @text_indent
              end
            end
          end
        end

        move_to_left "#{ _counter += 1 }.  HOLIDAYS VISITATION"

        if @all_holidays.length > 0

          push_text 'That the parties should follow the following Holiday schedule:', @text_indent

          @all_holidays.each do |holiday|
            push_text holiday[:child]

            holiday[:holidays].each do |holy|
              holiday_string = holy[0].template_field.name.split(' /<spain/>').first
              case holy.count
              when 3
                holiday_string += ": from #{ holy[1] } to #{ holy[2] }"
              when 4
                holiday_string += ": from #{ holy[1] } to #{ holy[2] }, #{ holy[3] }"
              when 5
                holiday_string += ": from #{ holy[1] } to #{ holy[2] } with #{ holy[3] }, #{ holy[4] }"
              when 7
                holiday_string += ": #{ holy[1] }, #{ holy[2] } from #{ holy[3] } to #{ holy[4] }, with #{ holy[5] }, #{ holy[6] }"
              end
              push_text holiday_string, @text_indent
            end
          end
        else
          push_text 'That the parties should not follow a specific Holiday schedule.', @text_indent
        end

        move_to_left "#{ _counter += 1 }.  CHILDREN’S HEALTH INSURANCE"

        health_insurance_text = "That "
        if @child_insurance == @plaintiff_full_name
          health_insurance_text += "#{ @mom.capitalize }"
        elsif @child_insurance == @defendant_full_name
          health_insurance_text += "#{ @dad.capitalize }"
        else
          health_insurance_text += 'Both'
        end
        health_insurance_text += " should maintain medical and dental insurance for the minor #{ @number_of_children > 1 ? 'children' : 'child' } if available. Any deductibles and expenses not covered by insurance should be paid equally by both parties."
        push_text health_insurance_text, @text_indent

        move_to_left "#{ _counter += 1 }.  CHILD SUPPORT"
        if @joint_children_count
          amount = (@mom_month_amount.to_f * (get_percentage_for_children(@joint_children_count).to_f / 100) - @dad_month_amount.to_f * (get_percentage_for_children(@joint_children_count).to_f / 100)).abs.round(2)
          push_text "That #{ @child_suport_who == "#{ @dad.capitalize } will pay $" ? @dad.capitalize : @mom.capitalize } should pay $ #{ amount } of #{ @mom_month_amount > @dad_month_amount ? @mom.capitalize : @dad.capitalize }'s gross monthly income, whichever amount is greater.", @text_indent
          push_text "The obligation to pay child support should continue until the #{ @joint_children_count > 1 ? 'children reaches' : 'child reach' } the age of 18 and no longer in high school, or 19 years of age, whichever occurs first, or emancipates.", @text_indent
        end

        case @child_suport_who
        when /I already have/
          push_text "That child support is being handled by the District Attorney’s Office, case (insert number) and should continue as ordered in that case.", @text_indent
        when /^No/
          push_text "That neither party should pay child support.", @text_indent
        when /will pay/
          case @how_pay
          when /following/
            push_text "That #{ @child_suport_who == "#{ @dad.capitalize } will pay #{ @number_of_children > 1 ? 'children' : 'child' } support" ? @dad.capitalize : @mom.capitalize } should pay the amount of $ #{ @child_suport_amount.to_i } per month in child support.", @text_indent
          when /statutory/
            count = get_number_of_primary_or_sole_child @document
            push_text "That #{ @child_suport_who == "#{ @dad.capitalize } will pay #{ @number_of_children > 1 ? 'children' : 'child' } support" ? @dad.capitalize : @mom.capitalize } should pay #{ get_percentage_for_children(count) } % of gross income or $100 per month whichever is higher as and for child support.", @text_indent
          end
          push_text "The obligation to pay child support should continue until the #{ @sole_primary_children_count > 1 ? 'children reaches' : 'child reach' } the age of 18 and no longer in high school, or 19 years of age, whichever occurs first, or emancipates.", @text_indent
        end

        move_to_left "#{ _counter += 1 }. WAGE WITHHOLDING"

        case @request_withhold
        when 'Yes'
          push_text 'That a wage withholding order be issued against the obligor parent to secure payment of child support and spousal support, if any.', @text_indent
        when 'No'
          push_text 'That Plaintiff is not asking for wage withholding.', @text_indent
        else
          push_text 'That there is already a child support action through the District Attorney’s Office and payment of the child support shall continue to be handled through that office.', @text_indent
        end

        move_to_left "#{ _counter += 1 }.  CHILD SUPPORT ARREARS"

        if @request_arrears
          push_text "That Plaintiff should be awarded back child support from #{ @request_arrears_from }, which is when the Plaintiff become the custodial parent. Plaintiff asks that this award be reduced to judgment and collectable by any legal means.", @text_indent
        else
          push_text 'The Plaintiff is not asking for back child support and waives Plaintiff’s rights to child support arrears.', @text_indent
        end

        move_to_left "#{ _counter += 1 }.  TAX DEDUCTION / EXEMPTIONS"
        @child_tax_examption.each do |tax|

          case tax.first
          when /^Should be/
            push_text "The tax deduction for #{ @children_info[tax.second][:full_name] } should be allocated per federal law.", @text_indent
          when /every/
            push_text "That #{ tax.first == "#{ @plaintiff_full_name } every year" ? @mom.capitalize : @dad.capitalize } should claim the minor child: #{ @children_info[tax.second][:full_name] }, as dependent for Federal Tax purposes every year.", @text_indent
          when /alternating years/
            if @number_of_children == 1
              push_text "That the parties should alternate claiming the minor child: #{ @children_info.first[:full_name] }, as dependent for Federal Tax purposes.", @text_indent
            elsif @number_of_children > 1
              push_text "That Plaintiff should claim minor #{ @children_info[tax.second][:full_name] }, as dependent for Federal Tax purposes every year. Defendant should claim minor #{ @children_info[tax.second][:full_name] }, as dependent for Federal Tax purposes every year.", @text_indent
            end
          end

        end

      # End of children
      end

      move_to_left "#{ _counter += 1 }.  COMMUNITY PROPERTY"
      mom_array = []
      dad_array = []
      mom_array.push "To the #{ @mom.capitalize}, as sole and separate property: "
      dad_array.push "To the #{ @dad.capitalize}, as sole and separate property: "
      if @pet_presence
        push_text 'That there is community property and other assets which should be divided by the Court as follows:', @text_indent
        @pets.each do |pet|

          case pet.last
          when "#{ @plaintiff_full_name } will keep"
            pet.pop
            mom_array.push pet.join(', ') if pet != '' || pet != ','
          when "#{ @defendant_full_name } will keep"
            pet.pop
            dad_array.push pet.join(', ') if pet != '' || pet != ','
          else
            mom_array.push pet.join(', ') if pet != '' || pet != ','
            dad_array.push pet.join(', ') if pet != '' || pet != ','
          end

        end

        if @property_presence != 'Yes'
          mom_array.each do |p|
            push_text p, @text_indent
          end
          dad_array.each do |p|
            push_text p, @text_indent
          end
        end
      end

      case @property_presence
      when 'Yes'
        push_text 'That there is community property and other assets which should be divided by the Court as follows:', @text_indent if !@pet_presence

        @properties_more.each do |property|
          case property.last
          when "#{ @plaintiff_full_name } will keep it"
            property.pop
            mom_array.push property.join(', ') if property != '' || property != ','
          when "#{ @defendant_full_name } will keep it"
            property.pop
            dad_array.push property.join(', ') if property != '' || property != ','
          else
            property[property.count - 1] = 'Sell'
            mom_array.push property.join(', ') if property != '' || property != ','
            dad_array.push property.join(', ') if property != '' || property != ','
          end
        end

        @debts_accounts.each do |property|
          case property.last
          when "#{ @plaintiff_full_name } will keep it"
            property.pop
            mom_array.push property.join(', ') if property != '' || property != ','
          when "#{ @defendant_full_name } will keep it"
            property.pop
            dad_array.push property.join(', ') if property != '' || property != ','
          else
            property[2] = 'Divide'
            mom_array.push property.join(', ') if property != '' || property != ','
            dad_array.push property.join(', ') if property != '' || property != ','
          end
        end

        @bank_account.each do |property|
          case property.last
          when "#{ @plaintiff_full_name } will keep it"
            property.pop
            mom_array.push property.join(', ') if property != '' || property != ','
          when "#{ @defendant_full_name } will keep it"
            property.pop
            dad_array.push property.join(', ') if property != '' || property != ','
          else
            property[4] = 'Divide'
            mom_array.push property.join(', ') if property != '' || property != ','
            dad_array.push property.join(', ') if property != '' || property != ','
          end
        end

        @other_properties.each do |property|
          case property.last
          when "#{ @plaintiff_full_name } will keep it"
            property.pop
            mom_array.push property.join(', ') if property != '' || property != ','
          when "#{ @defendant_full_name } will keep it"
            property.pop
            dad_array.push property.join(', ') if property != '' || property != ','
          else
            property[2] = 'Divide'
            mom_array.push property.join(', ') if property != '' || property != ','
            dad_array.push property.join(', ') if property != '' || property != ','
          end
        end


        alphabet = 96
        mom_array.each_with_index do |p, index|
          if mom_array.first == p
            push_text p, @text_indent
          else
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
        end
        alphabet = 96
        dad_array.each_with_index do |p, index|
          if dad_array.first == p
            push_text p, @text_indent
          else
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
        end


        push_text 'Plaintiff asks for leave to amend the Complaint once other assets are discovered and identified.', @text_indent
      when 'Yes'
        push_text "That if Defendant fails or refuses to sign the Quitclaim deed to the property and/or Vehicle Title so that the property becomes the sole and separate property of the Plaintiff, Plaintiff respectfully requests that the Clerk of the Court be directed to sign the (insert Quitclaim deed and/or Vehicle Title).", @text_indent
      when 'No, we already divided them'
        push_text 'That the parties have already divided all property and other assets and there is nothing for the Court to divide.', @text_indent
      else # Means 'No'
        push_text 'That there is no community property and/or other asset for the Court to divide.', @text_indent
      end

      move_to_left "#{ _counter += 1 }.  COMMUNITY DEBTS"
      case @community_debts
      when 'Yes'
        push_text 'That there are community debts which should be divided by the Court as follows:', @text_indent

        mom_array = []
        dad_array = []
        mom_array.push "To the #{ @mom.capitalize}, as sole and separate debts: "
        dad_array.push "To the #{ @dad.capitalize}, as sole and separate debts: "

        @debt_devision.each do |property|
          case property.last
          when "#{ @plaintiff_full_name } will keep"
            property.pop
            mom_array.push property.join(', ') if property != '' || property != ','
          when "#{ @defendant_full_name } will keep"
            property.pop
            dad_array.push property.join(', ') if property != '' || property != ','
          else
            property[property.count - 1] = 'Divide' if property.last == 'Pay with sell of home' || 'Pay with sell of land'
            mom_array.push property.join(', ') if property != '' || property != ','
            dad_array.push property.join(', ') if property != '' || property != ','
          end
        end

        alphabet = 96
        mom_array.each_with_index do |p, index|
          if mom_array.first == p
            push_text p, @text_indent
          else
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
        end
        alphabet = 96
        dad_array.each_with_index do |p, index|
          if dad_array.first == p
            push_text p, @text_indent
          else
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
        end


        push_text 'Plaintiff asks for leave to amend the Complaint once other debts are discovered and identified.', @text_indent
      when 'No, we already divided them'
        push_text 'That the parties have already equally divided their existing community debts.', @text_indent
      when 'No'
        push_text 'There are no community debts which should be divided by the court.', @text_indent
      end

      move_to_left "#{ _counter += 1 }.  ALIMONY"

      if @alimony_presence
        if @affidavit_of_support
          push_text "That alimony should be awarded to #{ @alimony_who == "#{ @plaintiff_full_name } WILL PAY spousal support" ? @mom.capitalize : @dad.capitalize} in the amount of #{ @alimony_how_much } per month for #{ @alimony_how_long } #{ @alimony_year_month.downcase }, since spouse filed the I-864 Affidavit of Support filed with U.S. Citizenship and Immigration Services.", @text_indent
        else
          push_text "That alimony should be awarded to #{ @alimony_who == "#{ @plaintiff_full_name } WILL PAY spousal support" ? @mom.capitalize : @dad.capitalize} in the amount of #{ @alimony_how_much } per month for #{ @alimony_how_long } #{ @alimony_year_month.downcase }.", @text_indent
        end
      else
        push_text 'That neither party should be awarded alimony.', @text_indent
      end

      if @wife_name_changing != 'Not applicable'
        move_to_left "#{ _counter += 1 }.  NAME CHANGE"

        name_change_text = "That #{ @wife_name_changing.match(@plaintiff_full_name) ? @mom.capitalize : @dad.capitalize } should have "

        if @wife_name_changing.match(@plaintiff_full_name)
          name_change_text += "#{ get_sex(@document).eql?('Male') ? 'his' : 'her' } former or maiden name of #{ @wife_name } restored to #{ get_sex(@document).eql?('Male') ? 'him' : 'her' }."
        else
          name_change_text += "#{ get_sex(@document, 'defendant').eql?('Male') ? 'his' : 'her' } former or maiden name of #{ @wife_name } restored to #{ get_sex(@document, 'defendant').eql?('Male') ? 'him' : 'her' }."
        end
        push_text name_change_text, @text_indent
      end

      if @court_cost_attorney_fees
        move_to_left "#{ _counter += 1 }.  ATTORNEY’S AND COST FEES"
        push_text 'That Plaintiff should be awarded attorney’s fees and court costs.', @text_indent
      end

      move_to_left "#{ _counter += 1 }.  REASON FOR DIVORCE"

      case @reason_divorce
      when /^I no longer want to be married and/
        push_text 'That the parties have lived separated and apart for more than one year and there is no possibility of reconciliation.', @text_indent
        push_text 'WHEREFORE, Plaintiff prays for a Judgment as follows:', @text_indent
        push_text '1. That the bond of matrimony heretofore and now existing between Plaintiff and Defendant be dissolved and that Plaintiff be granted an absolute Decree of Divorce and that each of the parties be restored to the status of a single, unmarried person; ', @text_indent
        push_text '2. That the Court grant the relief requested in this Complaint; and', @text_indent
        push_text '3. For such other relief as the Court finds to be just and proper.', @text_indent
      when /^I no longer want to be married/
        push_text 'That the parties have become so incompatible in marriage that there is no possibility of reconciliation.', @text_indent
      end

      move_down 30
      push_text 'DATED THIS _______day of  ___________, 20___'
      default_leading 0
      push_text 'Submitted by: __________________', 130
      push_text "#{ @plaintiff_full_name }   Signature", 200

      # move_down @header_margin_top
      # default_leading 8
      start_new_page

      if @clark_nye == 'Clark'
        push_header "<b>#{ @clark_nye.upcase } VERIFICATION</b>"
        move_down
        push_text 'Under penalties of perjury, I declare that I am the Plaintiff in the above-entitled action; that I have read the foregoing Complaint and know the contents thereof, that the pleading is true of my own knowledge, except for those matters therein contained stated upon information and belief, and that as to those matters, I believe them to be true.', @text_indent
        push_text 'I declare under penalty of perjury under the law of the State of Nevada that the foregoing is true and correct.', @text_indent
        move_down

        push_text 'DATED this _______day of  ___________, 20___'
        move_down 30
        default_leading 0
        push_text 'Submitted by: __________________'
        push_text "#{ @plaintiff_full_name }"
      else
        push_header "<b> VERIFICATION</b>"
        move_down

        push_text "STATE OF NEVADA#{ "\b"*17 })"
        push_text "#{ "\b"*52 }) ss:"
        push_text "COUNTY OF ______________)"
        move_down

        push_text "#{ @plaintiff_full_name }, under penalties of perjury, being first duly sworn, deposes and says:", @text_indent
        push_text "That I am the Plaintiff in the above-entitled action; that I have read the foregoing Complaint for Divorce and know the contents thereof; that the same is true of my own knowledge, except for those matters therein contained stated upon information and belief, and as to those matters, I believe them to be true.", @text_indent
        move_down
        push_text "By:", 300
        push_text "________________________________", 300
        push_text "#{ @plaintiff_full_name }   Signature", 300
        move_down 20
        push_text "SUBSCRIBED and SWORN to before me"
        move_down
        push_text "this ______ day of __________20____ by #{ @plaintiff_full_name }"
        move_down 20
        push_text "__________________________________________________"
        push_text "NOTARY PUBLIC"
        move_down 40

        push_header "<b>ACKNOWLEDGMENT</b>"
        move_down
        push_text "STATE OF NEVADA#{ "\b"*17 })"
        push_text "#{ "\b"*52 }) ss:"
        push_text "COUNTY OF ______________)"
        move_down 40
        push_text "On this _______ day of ____________, 20____, personally appeared before me, Notary Public, #{ @plaintiff_full_name }, known or proved to me to be the person who executed the foregoing Complaint for Divorce, and who acknowledged to me that #{ get_sex(@document).eql?('Male') ? 'he' : 'she' } did so freely and voluntarily and for the uses and purposes therein mentioned. WITNESS my hand and official seal.", @text_indent
        move_down
        push_text "_____________________________________________________"
        push_text "SIGNATURE - NOTARY PUBLIC"
      end

      finishing
    end
  end
end














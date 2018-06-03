module PdfDocument
  class DecreeOfDivorce < DivorceWrapper
    include DivorceComplaintHelper

    def can_generate?
      @packet =~ /Divorce/
    end

    def generate
      _counter = 0
      default_leading 5
      push_text '<b>DECD</b>'

      push_text @plaintiff_full_name
      push_text "#{ @plaintiff_mailing_address } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }"

      push_text @plaintiff_phone
      push_text @plaintiff_email
      push_text 'Plaintiff Self-Represented'

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
      push_header 'DECREE OF DIVORCE OR DECRE OF SEPARATE MAINTENANCE'
      push_text 'THIS cause coming on for summary disposition before the above-entitled court, and after reviewing the pleadings and papers on file, the Court finds as follows:', @text_indent

      move_to_left "#{ _counter += 1 }. COURT JURISDICTION"
      push_text 'That the Court has complete jurisdiction in the premises, both as to the subject matter thereof as well as the parties hereto:', @text_indent

      move_to_left "#{ _counter += 1 }. RESIDENCY"
      push_text "That the Plaintiff is a resident of the State of Nevada, County #{ @clark_nye.upcase } and for a period of more than six (6) weeks immediately preceding the commencement of this action has resided in, been physically present in, and is a resident of the State of Nevada, and intends to continue to make the State of Nevada #{ @mam == 'plaintiff' ? 'her' : 'his' } home for the indefinite period of time.", @text_indent

      move_to_left "#{ _counter += 1 }. MARRIAGE INFORMATION"
      case @reason_divorce
      when 'I no longer want to be married'
        push_text "That the parties were married on the #{ @marriage_date_decree } #{ @marriage_country_decree }. The parties are incompatible in marriage and there is no hope for reconciliation.", @text_indent
      else
        push_text "The parties have lived separate and apart for over one year without cohabitation and there is no hope for reconciliation. ", @text_indent
      end

      move_to_left "#{ _counter += 1 }. PREGNACY"
      if @pregnacy
        push_text "Wife is this case is currently pregnant. Husband #{ @pregnacy_unborn ? 'is' : 'is not' } the father of the unborn child. The unborn child is due to be born #{ @pregnacy_date }.", @text_indent
      else
        push_text 'Wife in this case is not currently pregnant.', @text_indent
      end

      if @children_nevada_residency
        move_to_left "#{ _counter += 1 }. MINOR CHILDREN"
        minor_children_text = "That the parties have #{ @number_of_children } minor #{ @number_of_children > 1 ? 'children' : 'child' } who #{ @number_of_children > 1 ? 'are' : 'is' } the issue of this marriage or have been adopted by the parties."
        minor_children_text += ' The '
        @children_info.each_with_index do |child, index|
          minor_children_text += "#{ child[:full_name] } born #{ child[:date_of_birth] }"
          minor_children_text += @children_info.count == index + 1 ? '.' : '; '
        end


        push_text minor_children_text, @text_indent

        move_to_left "#{ _counter += 1 }. MINOR CHILDREN RESIDENCY"
        if @children_nevada_residency
          push_text "Nevada is the habitual residence of the #{ @number_of_children > 1 ? 'children' : 'child' } and this Court does have the jurisdiction to enter orders regarding custody and visitation.", @text_indent
        else
          push_text "The #{ @number_of_children > 1 ? 'children are' : 'child is' } residents of the State of Nevada. This Court does not have the jurisdiction to enter orders regarding custody and visitation.", @text_indent
        end

        move_to_left "#{ _counter += 1 }. LEGAL CUSTODY"
        @legal_custody_parent.each do |legal_custody|
          case legal_custody
          when 'BOTH Parents'
            push_text "The parties are fit and proper people to be awarded JOINT LEGAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
          else
            push_text "The #{ legal_custody.eql?('Only MOM') ? @mom.capitalize : @dad.capitalize } is a fit and proper person to be awarded SOLE LEGAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
          end
        end

        move_to_left "#{ _counter += 1 }. PHYSICAL CUSTODY"
        @physical_custody_parent.each do |physical_custody|
          case physical_custody[:custody]
          when /^With/
            push_text " The #{ physical_custody[:custody].eql?('With mom and visits with dad') ? @mom.capitalize : @dad.capitalize } is a fit and proper person to be awarded PRIMARY PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' } with #{ physical_custody[:custody].eql?('With mom and visits with dad') ? @dad.capitalize : @mom.capitalize } having visitation as set forth below.", @text_indent
          when /^Both/
            push_text "The parties are fit and proper person to be awarded JOINT PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }. The parties should have visitation as set forth below.", @text_indent
          when /^Only/
            push_text "The #{ physical_custody[:custody].eql?('Only with the mom') ? @mom.capitalize : @dad.capitalize } is a fit and proper person to be awarded SOLE PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
          end
        end

        move_to_left "#{ _counter += 1 }. MINOR CHILDREN HEALTH INSURANCE"
        case @child_insurance
        when 'Both Parents'
          push_text " That both parties should both maintain medical and dental insurance for the minor #{ @number_of_children > 1 ? 'children' : 'child' } through the employer, if available. Any deductibles and expenses not covered by insurance should be paid equally by both parties.", @text_indent
        else
          push_text "That #{ @child_insurance.eql?('Mom') ? @mom.capitalize : @dad.capitalize } should maintain medical and dental insurance for the minor #{ @number_of_children > 1 ? 'children' : 'child' } through the employer, if available.  Any deductibles and expenses not covered by insurance should be paid equally by both parties.", @text_indent
        end

        move_to_left "#{ _counter += 1 }. CHILD SUPPORT"
        case @child_suport_who
        when /will/
          case @how_pay
          when /following/
            push_text "That #{ @child_suport_who.eql?('Dad will pay $') ? @dad.capitalize : @mom.capitalize } should pay $ #{ @child_suport_amount.to_i } per month for support of the parties' minor #{ @number_of_children > 1 ? 'children' : 'child' }. This amount is in compliance with NRS 125B.070. The obligation to pay child support should continue until the #{ @number_of_children > 1 ? 'children reaches' : 'child reach' } the age of 18 and no longer in high school, or 19 years of age, whichever occurs first, or emancipates.", @text_indent
          else
            count = get_number_of_primary_or_sole_child(@document)
            push_text "That #{ @child_suport_who.eql?('Dad will pay $') ? @dad.capitalize : @mom.capitalize } should pay child support in the statutory minimum of $100 per month, per child or % #{ get_percentage_for_children(@number_of_children - count) } of #{ @child_suport_who.eql?('Dad will pay $') ? @mom.capitalize : @dad.capitalize } gross monthly income whichever is greater as is in compliance with NRS 125B.070. The obligation to pay child support should continue until the #{ @number_of_children > 1 ? 'children reaches' : 'child reach' } the age of 18 and no longer in high school, or 19 years of age, whichever occurs first, or emancipates. ", @text_indent
          end
        when /^No/
          push_text "That neither party should pay child support.", @text_indent
        end
      end

      move_to_left "#{ _counter += 1 }. COMMUNITY PROPERTY"
      case @property_presence
      when 'Yes'
        push_text "That the community property division set forth below is, to the extent possible, an equal distribution of the community property.", @text_indent
      else
        push_text "That there is no community property to be adjudicated by the Court.", @text_indent
      end

      move_to_left "#{ _counter += 1 }. COMMUNITY DEBTS"
      case @community_debts
      when 'Yes'
        push_text "That the community debts set forth below is, to the extent possible, an equal distribution of the community debts.", @text_indent
      else
        push_text "There are no community debts to be adjudicated by the Court.", @text_indent
      end

      move_to_left "#{ _counter += 1 }. SPOUSAL SUPPORT"
      if @alimony_presence
        push_text "That the Court should aware spousal support as set forth below.", @text_indent
      else
        push_text "That neither party should be awarded spousal support.", @text_indent
      end

      move_to_left "#{ _counter += 1 }. NAME CHANGE"
      case @wife_name_changing
      when /^Wife never/
        push_text "That the wife never changed her name and should not have her former or maiden name restored to her.", @text_indent
      when /^Wife will keep/
        push_text "That the wife should not have her former or maiden name restored.", @text_indent
      when /^Wife will return/
        push_text "That the wife should have her former or maiden name of #{ @wife_name } restored to her.", @text_indent
      end

      move_to_left "#{ _counter += 1 }. REASON FOR DIVORCE"
      push_text "That Plaintiff should be granted a Decree of Divorce for the reasons set forth in the Complaint.", @text_indent

      push_text "<b>THEREFORE, IT IS ORDERED, ADJUDGED AND DECREED</b> that the bonds of matrimony now and heretofore existing between the parties are hereby wholly dissolved, set aside and forever held for naught, and an absolute Decree of Divorce is hereby granted to the parties, and each of the parties are hereby restored to the status of a single, unmarried person.", @text_indent

      if @children_nevada_residency
        @physical_custody_parent.each_with_index do |physical_custody, index|
          case physical_custody[:custody]
          when /^Both/
            push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the parties are awarded JOINT LEGAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
          when /^Only/
            push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the #{ physical_custody[:custody] == 'Only with the mom' ? @mom.capitalize : @dad.capitalize } is awarded SOLE LEGAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
          end
        end

        @physical_custody_parent.each do |physical_custody|
          case physical_custody[:custody]
          when /and visit/
            push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the #{ physical_custody[:custody] == 'With mom and visits with dad' ? @mom.capitalize : @dad.capitalize } is awarded PRIMARY PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' } with #{ physical_custody[:custody] == 'With mom and visits with dad' ? @dad.capitalize : @mom.capitalize } having visitation as follows:", @text_indent
            physical_custody[:answers].each_with_index do |answer, index|
              push_text "#{ (97 + index).chr }. #{ answer }"
            end
          when /^Both/
            push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the parties are awarded JOINT PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' } and the parties’ timeshare should be as follows:", @text_indent
            physical_custody[:answers].each_with_index do |answer, index|
              push_text "#{ (97 + index).chr }. #{ answer }"
            end
          when /^Only/
            push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the #{ physical_custody[:custody] == 'Only with the mom' ? @mom.capitalize : @dad.capitalize } is awarded SOLE PHYSICAL custody of the minor #{ @number_of_children > 1 ? 'children' : 'child' }.", @text_indent
          end
        end

        if @holiday_now
          holiday_text = "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the holiday visitation schedule is as follows: "
          @all_holidays.each do |holiday|
            holiday_text += holiday[:child].to_s

            holiday[:holidays].each do |holy|
              holiday_text += holy[0].template_field.name.split(' /<spain/>').first
              case holy.count
              when 3
                holiday_text += ": from #{ holy[1] } to #{ holy[2] }; "
              when 4
                holiday_text += ": from #{ holy[1] } to #{ holy[2] }, #{ holy[3] }; "
              when 5
                holiday_text += ": from #{ holy[1] } to #{ holy[2] } with #{ holy[3] }, #{ holy[4] }; "
              when 7
                holiday_text += ": #{ holy[1] }, #{ holy[2] } from #{ holy[3] } to #{ holy[4] }, with #{ holy[5] }, #{ holy[6] }; "
              end
            end
          end
          holiday_text += "The holiday visitation schedule shall control when in conflict with the regular visitation schedule."
          push_text holiday_text, @text_indent
        else
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that no holiday schedule is being ordered.", @text_indent
        end

        case @child_insurance
        when /^Both/
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that both parties shall maintain medical and dental insurance for the minor #{ @number_of_children > 1 ? 'children' : 'child' } if available. Any deductibles and expenses not covered by insurance should be paid equally by both parties, pursuant to the 30/30 Rule.", @text_indent
        else
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that #{ @child_insurance == 'Dad' ? @dad.capitalize : @mom.capitalize } shall maintain medical and dental insurance for the minor #{ @number_of_children > 1 ? 'children' : 'child' } if available.  Any deductibles and expenses not covered by insurance should be paid equally by both parties, pursuant to the 30/30 Rule.", @text_indent
        end

        case @child_suport_who
        when /^No/
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that neither party shall pay child support.", @text_indent
        when /^Dad|^Mom/
          case @how_pay
          when /following/
            push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that #{ @child_suport_who == 'Dad will pay <child> support' ? @dad.capitalize : @mom.capitalize } shall pay $ #{ @child_suport_amount } per month in child support. Pursuant to NRS 125.510, this amount shall continue until the minor child reaches 18 years of age if no longer in high school, or if the child still enrolled in high school, when the child reaches 19 years of age or becomes emancipated or otherwise self-supporting.", @text_indent
          when /statutory/
            count = get_number_of_primary_or_sole_child @document
            push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that #{ @child_suport_who == 'Dad will pay <child> support' ? @dad.capitalize : @mom.capitalize } shall pay child support in the amount of #{ get_percentage_for_children(count) } % of #{ @child_suport_who == 'Dad will pay <child> support' ? @mom.capitalize : @dad.capitalize } gross monthly income or the minimum required by law and is in compliance with NRS 125B.070.  Pursuant to NRS 125.510, this amount shall continue until the minor child reaches 18 years of age if no longer in high school, or if the child still enrolled in high school, when the child reaches 19 years of age or becomes emancipated or otherwise self-supporting.", @text_indent
          end
        end

        case @request_withhold
        when 'Yes'
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that a wage withholding shall issue against the obligor parent to secure payment of child support and spousal support, if any.", @text_indent
        else
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that no wage withholding shall be order at this time.", @text_indent
        end

        if @request_arrears
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that Plaintiff is awarded child support arrearages in the total of $ #{ @request_amount_paid }, which amount is reduced to judgment against Defendant. ", @text_indent
        else
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that no child support arrearages exist and Plaintiff waives the right to child support arrearages.", @text_indent
        end

        tax_exemptions_text = "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> "
        @child_tax_examption.each do |tax|
          case tax.first
          when /^Should be/
            tax_exemptions_text += "The tax deduction shall be allocated per federal law."
            push_text tax_exemptions_text, @text_indent
            tax_exemptions_text = ''
          when /^Mom every|^Dad every/
            tax_exemptions_text += "#{ tax.first == 'Mom every year' ? @mom.capitalize : @dad.capitalize} shall claim the following minor child #{ @children_info[tax.second][:full_name] } as dependent for Federal Tax purposes every year."
            push_text tax_exemptions_text, @text_indent
            tax_exemptions_text = ''
          when /^Dad and Mom/
            tax_exemptions_text += "Plaintiff should claim minor #{ @children_info[tax.second][:full_name] } as dependent for Federal Tax purposes every year.  Defendant should claim minor #{ @children_info[tax.second][:full_name] } as dependent for Federal Tax purposes every year."
            push_text tax_exemptions_text, @text_indent
            tax_exemptions_text = ''
          end
        end

        tax_exemption_text = "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> "
        @child_tax_examption.each do |tax|
          case tax.first
          when /^Should be/
            tax_exemption_text += "That the parties should alternate claiming the minor #{ @number_of_children > 1 ? 'children' : 'child' } as dependent(s) for Federal Tax purposes. "
            push_text tax_exemption_text, @text_indent
            tax_exemption_text = ''
          when /^Mom every|^Dad every/
            tax_exemption_text += "That #{ tax.first == 'Mom every year' ? @mom.capitalize : @dad.capitalize} should claim the minor #{ @number_of_children > 1 ? 'children' : 'child' } as dependent(s) for Federal Tax purposes every year."
            push_text tax_exemption_text, @text_indent
            tax_exemption_text = ''
          when /^Dad and Mom/
            tax_exemption_text += "That Plaintiff should claim minor #{ @children_info[tax.second][:full_name] } as dependent(s) for Federal Tax purposes every year.  Defendant should claim minor #{ @children_info[tax.second][:full_name] } as dependent(s) for Federal Tax purposes every year."
            push_text tax_exemption_text, @text_indent
            tax_exemption_text = ''
          end
        end

        case @property_presence
        when 'Yes'
          push_text " <b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that community property which shall be equally divided as follows:", @text_indent
          mom_array = []
          dad_array = []
          @properties_more.each do |property|
            case property.last
            when /^Wife will keep/
              property.pop
              mom_array.push property.join(', ') if property != '' || property != ','
            when /^Husband will keep/
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
            when /^Wife will keep it/
              property.pop
              mom_array.push property.join(', ') if property != '' || property != ','
            when /^Husband will keep it/
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
            when /^Wife will keep it/
              property.pop
              mom_array.push property.join(', ') if property != '' || property != ','
            when /^Husband will keep it/
              property.pop
              dad_array.push property.join(', ') if property != '' || property != ','
            else
              property[4] = 'Divide'
              mom_array.push property.join(', ') if property != '' || property != ','
              dad_array.push property.join(', ') if property != '' || property != ','
            end
          end
          push_text "To the Plaintiff, as #{ @mom == 'plaintiff' ? 'her' : 'his' } sole and separate property:", @text_indent
          property_array = @mom == 'plaintiff' ? mom_array : dad_array
          alphabet = 97
          property_array.each_with_index do |p, index|
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
          push_text "To the Defendant, as #{ @dad == 'defendant' ? 'his' : 'her' } sole and separate property:", @text_indent
          property_array = @dad == 'defendant' ? dad_array : mom_array
          alphabet = 97
          property_array.each_with_index do |p, index|
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
        when 'No, we already divided them'
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that community property and it has been already divided.", @text_indent
        else
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that there is no community property to divide.", @text_indent
        end

        community_debt_text = ""
        case @community_debts
        when 'Yes'
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that there is community debt which shall be equally divided as follows: ", @text_indent

          mom_array = []
          dad_array = []
          @debt_devision.each do |property|
            case property.last
            when /^Wife will keep/
              property.pop
              mom_array.push property.join(', ') if property != '' || property != ','
            when /^Husband will keep/
              property.pop
              dad_array.push property.join(', ') if property != '' || property != ','
            else
              property[property.count - 1] = 'Divide' if property.last == 'Pay with sell of home' || 'Pay with sell of land'
              mom_array.push property.join(', ') if property != '' || property != ','
              dad_array.push property.join(', ') if property != '' || property != ','
            end
          end

          push_text "To the Plaintiff, as #{ @mom == 'plaintiff' ? 'her' : 'his' } sole and separate debts and shall indemnify and hold Defendant harmless from these debts:", @text_indent
          debt_array = @mom == 'plaintiff' ? mom_array : dad_array
          alphabet = 97
          debt_array.each_with_index do |p, index|
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
          push_text "To the Defendant, as #{ @dad == 'defendant' ? 'his' : 'her' } sole and separate debts and shall indemnify and hold Plaintiff harmless from these debts:", @text_indent
          debt_array = @dad == 'defendant' ? dad_array : mom_array
          alphabet = 97
          debt_array.each_with_index do |p, index|
            push_text "#{ (alphabet+index).chr }. #{ p }", @text_indent
          end
        when 'No, we already divided them'
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that there is community debt and it has been already divided.", @text_indent
        else
          push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that there is no community debt to divide.", @text_indent
        end
      end

      if @alimony_presence
        push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that #{ @alimony_who } shall pay $ #{ @alimony_how_much } per month in spousal support for #{ @alimony_how_long } #{ @alimony_year_month }. This amount is fair and equitable.", @text_indent
      else
        push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that there is no spousal support awarded.", @text_indent
      end

      case @wife_name_changing
      when /^Wife never/
        push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the wife never changed her name and does not request restoration of her former name.", @text_indent
      when /^Wife will keep/
        push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the wife does not wish to return to her former name.", @text_indent
      when /^Wife will return/
        push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that the wife wishes to return to her former name of #{ @wife_name }.", @text_indent
      end

      push_text "<b>IT IS FURTHER ORDERED, ADJUDGED AND DECREED</b> that each party shall submit the information required in NRS 125B.055, NRS 125.130 and NRS 125.230 on a separate form to the Court and the Welfare Division of the Department of Human Resources within ten days from the date this Decree is filed. Such information shall be maintained by the Clerk in a confidential manner and not part of the public record.  The parties shall update the information filed with the Court and the Welfare Division of the Department of Human Resources within ten days should any of that information become inaccurate. ", @text_indent
      push_text "<b>NOTICE IS HEREBY GIVEN</b> of the following provision of NRS 125.510(6): <u>PENALTY FOR VIOLATION OF ORDER:</u> THE ABDUCTION, CONCEALMENT OR DETENTION OF A CHILD IN VIOLATION OF THIS ORDER IS PUNISHABLE AS A CATEGORY D FELONY AS PROVIDED IN NRS 193.130. NRS 200.359 provides that every person having a limited right of custody to a child or any parent having no right of custody to the child who willfully detains, conceals or removes the child from a parent, guardian or other person having lawful custody or a right of visitation of the child in violation of an order of this court, or removes the child from the jurisdiction of the court without the consent of either the court or all persons who have the right to custody or visitation is subject to being punished for a category D felony as provided in NRS 193.130. ", @text_indent
      push_text "<b>NOTICE IS HEREBY GIVEN</b> that the terms of the Hague Convention of October 25, 1980, adopted by the 14th Session of the Hague Conference on Private International Law, apply if a parent abducts or wrongfully retains a child in a foreign country.  The parties are also put on notice of the following provisions in NRS 125.510(8):", @text_indent
      push_text "(a) The parties may agree, and the court shall include in the order for custody of the child, that the United States is the country of habitual residence of the child for the purposes of applying the terms of the Hague Convention as set forth in subsection 7.", @text_indent
      push_text "(b) Upon motion of one of the parties, the court may order the parent to post a bond if the court determines that the parent poses an imminent risk of wrongfully removing or concealing the child outside the country of habitual residence. The bond must be in an amount determined by the court and may be used only to pay for the cost of locating the child and returning the child to his or her habitual residence if the child is wrongfully removed from or concealed outside the country of habitual residence. The fact that a parent has significant commitments in a foreign country does not create a presumption that the parent poses an imminent risk of wrongfully removing or concealing the child.", @text_indent
      push_text "<b>NOTICE IS HEREBY GIVEN</b> of the following provision of NRS 125C.200: If custody has been established and the custodial parent intends to move his or her residence to a place outside of this State and to take the child with him or her, the custodial parent must, as soon as possible and before the planned move, attempt to obtain the written consent of the noncustodial parent to move the child from this state. If the noncustodial parent refuses to give that consent, the custodial parent shall, before he leaves this State with the child, petition the court for permission to move the child. The failure of a parent to comply with the provisions of this section may be considered as a factor if a change of custody is requested by the noncustodial parent.", @text_indent
      push_text "<b>NOTICE IS HEREBY GIVEN</b> that they are subject to the provisions of NRS 31A and 125.450 regarding the collection of delinquent child support payments.", @text_indent
      push_text "<b>NOTICE IS HEREBY GIVEN</b> that either party may request a review of child support pursuant to NRS 125B.145.", @text_indent

      move_down 30
      push_text 'DATED THIS _______day of  ___________, 20___', @text_indent
      move_down 30
      default_leading 0
      push_text '__________________________________', 240
      push_text 'DISTRICT COURT JUDGE', 240
      move_down 30
      push_text 'Respectfully Submitted by:'
      move_down 30

      default_leading 8
      table_row []
      table_row [{ :content => "#{ '_'*30 }", :border_width => 0 }, { :content => "#{ '_'*30 }", :border_width => 0 }]
      table_row [{ :content => "Plaintiff Signature\n\n #{ @plaintiff_full_name }\n#{ @plaintiff_mailing_address } #{ @plaintiff_mailing_address_city }, #{ @plaintiff_mailing_address_state } #{ @plaintiff_mailing_address_zip }\n#{ @plaintiff_phone }\n#{ @plaintiff_email }", :border_width => 0 }, { :content => "Defendant Signature\n\n#{ @defendant_full_name }\n#{ @defendant_mailing_address } #{ @defendant_city }, #{ @defendant_country.present? ? @defendant_country : @defendant_state } #{ @defendant_zip }\n#{ @defendant_phone }\n#{ @defendant_email }", :border_width => 0 }]
      push_table -1, 0
      default_leading 0

      finishing
    end
  end
end
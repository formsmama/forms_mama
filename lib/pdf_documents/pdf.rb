module PdfDocument
  class Pdf
    require 'pdf_documents/wrapper'
    require 'pdf_documents/divorce_wrapper'
    require 'prawn'
    Dir["lib/pdf_documents/documents/*.rb"].each do |file|
      require "pdf_documents/documents/#{ File.basename(file, ".rb") }"
    end


    def generate(document)
      user_folder = document.owner.id.to_s
      FileUtils.rm_rf("#{Rails.root}/documents/pdf/#{ user_folder }/#{ document.template_name.split(' /<spain/>').first }")

      case document.template.to_s
      when /^Complaint for Divorce/
        divorce_complaint = PdfDocument::DivorceComplaint.new(document)
        uccja = PdfDocument::Uccja.new(document)
        cover = PdfDocument::DivorceCover.new(document)
        coversheet = PdfDocument::DivorceCoversheet.new(document)
        summons = PdfDocument::DivorceSummons.new(document)
        injunction = PdfDocument::DivorceInjunction.new(document)
        # decree_of_divorce = PdfDocument::DecreeOfDivorce.new(document)
        welfare_sheet = PdfDocument::WelfareSheet.new(document)
        affidavit_of_resident_witness = PdfDocument::AffidavitOfResidentWitness.new(document)

        generate_document divorce_complaint.generate,                   "Complaint", document, true, true, "Divorce_complaint" if divorce_complaint.can_generate?
        generate_document cover.generate,                               "Cover", document if cover.can_generate?
        generate_document coversheet.generate,                          "Cover", document if coversheet.can_generate?
        generate_document summons.generate,                             "Summons", document if summons.can_generate?
        generate_document injunction.generate,                          "Injunction(Optional)", document if injunction.can_generate?
        generate_document uccja.generate,                               "UCCJA", document if uccja.can_generate?

        # generate_document decree_of_divorce.generate,   "Decree_of_divorce", document, true, true, "Decree_of_divorce" if decree_of_divorce.can_generate?
        generate_document welfare_sheet.generate,                       "Welfare_sheet", document if welfare_sheet.can_generate?
        generate_document affidavit_of_resident_witness.generate,       "Affidavit Of Resident Witness", document if affidavit_of_resident_witness.can_generate?


      when /^Filed Case/
        acceptance_of_service = PdfDocument::AcceptanceOfService.new(document)
        affidavit_of_service = PdfDocument::AffidavitOfService.new(document)

        generate_document acceptance_of_service.generate,                       "Acceptance_of_service", document if acceptance_of_service.can_generate?
        generate_document affidavit_of_service.generate,                        "Affidavit_of_service", document if affidavit_of_service.can_generate?
        # generate_document PdfDocument::DefaultDivorce.new(document).generate,   "Default_divorce", document
        # generate_document PdfDocument::NoticeOfEntry.new(document).generate,    "Notice_of_entry", document, true, true, "Notice_of_entry"
      end
    end

    def generate_document(wrapped_document, pdf_name, document, judical_layout=false, footer_layout=false, footer_name = '')

      if judical_layout
        numbers = ''; 28.times do |i| numbers += "\n\n#{ i + 1 }" end
        leading = 8
      end

      user_folder = document.owner.id.to_s
      Dir.mkdir("#{Rails.root}/documents/pdf/#{ user_folder }") unless File.exists?("#{Rails.root}/documents/pdf/#{ user_folder }")
      Dir.mkdir("#{Rails.root}/documents/pdf/#{ user_folder }/#{ document.template_name.split(' /<spain/>').first }") unless File.exists?("#{Rails.root}/documents/pdf/#{ user_folder }/#{ document.template_name.split(' /<spain/>').first }")

      Prawn::Document.generate("documents/pdf/#{ document.owner.id }/#{ document.template_name.split(' /<spain/>').first }/#{ pdf_name }.pdf") do
        font "Times-Roman"

        if !judical_layout
          #default page params
          bound_left = bounds.left
          bound_top = bounds.top + 20
          width = 540
          height = bounds.height + 20
          padding_left = 0

        else
          #page params for judical layout
          bound_left = bounds.left + 20
          bound_top = bounds.top - 37
          width = 503
          height = bounds.height - 97
          padding_left = 5

          repeat :all do
            #Header, invisible
            canvas do
              bounding_box([bounds.left, bounds.top], :width => bounds.width) do
                cell :width => bounds.width, :height => 50, :borders => []
              end
            end
            #Left vertical line with numbers
            canvas do
              bounding_box([bounds.left, bounds.top], :width => 50, :height => bounds.height, :page_filter => :all) do
                cell :width => 50,
                     :height => bounds.height,
                     :borders => [:right],
                     :border_width => 1,
                     :border_color => '858585',
                     #:background_color => '858585'
                     :content => numbers,
                     :align => :right,
                     :text_color => "858585",
                     :padding_top => 50,
                     :size => 10
              end
            end
            #Second left vertical line
            canvas do
              bounding_box([bounds.left + 53, bounds.top], :width => 1, :height => bounds.height) do
                cell :width => 1,
                     :height => bounds.height,
                     :borders => [:left],
                     :border_width => 1
              end
            end
            #Right vertical line
            canvas do
              bounding_box([bounds.right - 50, bounds.top], :width => 1, :height => bounds.height) do
                cell :width => 1,
                     :height => bounds.height,
                     :borders => [:left],
                     :border_color => '858585',
                     :border_width => 1
              end
            end
          end
        end

        # #BODY
        bounding_box([bound_left, bound_top], :width => width, :height => height) do
          cell :width => width, :height => height, :borders => [], :padding_left => padding_left

          wrapped_document.amount.times do

            next_element = wrapped_document.next
            next_line = next_element.last
            command   = next_element.first
            command_number = command.split(' ').second.to_i rescue nil
            if command.split(' ').length > 2
              additional_command = command.split(' ').last.to_i
            else
              additional_command = -1
            end

            case command
            when 'text'
              text next_line, :inline_format => true
            when /^text-right /
              font_size(command_number){ text next_line, :align => :right }
            when /^text /
              text next_line, :inline_format => true, :indent_paragraphs => command_number
            when /^header /
              font_size(command_number){ text next_line, :align => :center, :inline_format => true }
            when /^table /
              _font_size = additional_command == 0 ? 10 : 8
              table next_line, :width => width, :cell_style => { :inline_format => true, :size => _font_size, :font => "Times-Roman" } do

                cells.style :valign => :top
                cells.style :padding => [3, 0, 4, 3]
                cells.row(0).background_color = 'DFDFDF' if command_number > -1
                cells.row(command_number).background_color = 'DFDFDF' if command_number > 0
                if command_number == -2
                  cells.style :padding => [15, 20, 15, 20]
                end
              end
            when 'new_page'
              start_new_page
            when /^default_leading/
              default_leading command[command.length - 1].to_i
            when /^rectangle/
              array_tmp = command.split(' ')
              stroke_color '000000'
              stroke_rectangle [array_tmp.second.to_i, array_tmp.last.to_i], 10, 10
            when /^small_rectangle/
              array_tmp = command.split(' ')
              stroke_color '000000'
              stroke_rectangle [array_tmp.second.to_i, array_tmp.last.to_i], 8, 8
            when /^checked_rectangle/
              array_tmp = command.split(' ')
              stroke_color '000000'
              stroke_rectangle [array_tmp.second.to_i, array_tmp.last.to_i], 10, 10
              stroke_line [array_tmp.second.to_i, array_tmp.last.to_i - 5], [array_tmp.second.to_i + 5, array_tmp.last.to_i - 10]
              stroke_line [array_tmp.second.to_i + 5, array_tmp.last.to_i - 10], [array_tmp.second.to_i + 10, array_tmp.last.to_i]
            when /^small_checked_rectangle/
              array_tmp = command.split(' ')
              stroke_color '000000'
              stroke_rectangle [array_tmp.second.to_i, array_tmp.last.to_i], 8, 8
              stroke_line [array_tmp.second.to_i, array_tmp.last.to_i - 4], [array_tmp.second.to_i + 4, array_tmp.last.to_i - 8]
              stroke_line [array_tmp.second.to_i + 4, array_tmp.last.to_i - 8], [array_tmp.second.to_i + 8, array_tmp.last.to_i]
            when /^move_to_left/
              font_size(command_number){ text next_line, :indent_paragraphs => 170, :inline_format => true }
            when /^create_line/
              array_tmp = command.split(' ')
              stroke do
                horizontal_line array_tmp.second.to_i, array_tmp.third.to_i, :at => array_tmp.fourth.to_i
              end
            when /\d/
              move_down next_line.to_i
            end
          end
        end

        if footer_layout
          bounding_box [bounds.left, bounds.bottom + 35], :width  => bounds.width do
            number_pages "www.FormsMama.com                          Page <page> of <total>                    #{ footer_name.titleize } #{ Time.now.year }", { :start_count_at => 0, :page_filter => :all, :align => :center, :size => 12, :color => '858585' }
          end
        end
      end
    end
  end
end
module PdfDocument
  class Wrapper

    @color_gray = 'DFDFDF'

    def next
      @data_array_enum.next
    end

    def amount
      @data_array.try(:length).to_i || 0
    end

    protected
    def step_answers_enum(step, loop_step=0)
      step.fields.map{ |f| f.document_answers.where(:document_id => @document_id).order('id')[loop_step] }.reverse.to_enum
    end

    def step_answers_looped_enum(step)
      step.fields.map{ |f| f.document_answers.where(:document_id => @document_id) }.reverse.to_enum
    end

    def push_text(text, indent=0)
      @data_array.push ["text #{ indent.to_s }", text]
    end

    def push_text_right(text, size=10)
      @data_array.push ["text-right #{ size.to_s }", text]
    end

    def push_header(text, size=13)
      @data_array.push ["header #{ size.to_s }", text]
    end

    def move_down(number=10)
      @data_array.push [number.to_s]
    end

    def default_leading(number=2)
      @data_array.push ["default_leading #{ number.to_s }"]
    end

    def move_to_left(text, size=13)
      @data_array.push ["move_to_left #{ size.to_s }", text]
    end

    def rectangle(x_position, y_position)
      @data_array.push ["rectangle #{x_position} #{y_position}"]
    end

    def small_rectangle(x_position, y_position)
      @data_array.push ["small_rectangle #{x_position} #{y_position}"]
    end

    def rectangle_checked(x_position, y_position)
      @data_array.push ["checked_rectangle #{x_position} #{y_position}"]
    end

    def small_rectangle_checked(x_position, y_position)
      @data_array.push ["small_checked_rectangle #{x_position} #{y_position}"]
    end

    def create_line(x_position, width, y_position)
      @data_array.push ["create_line #{x_position} #{ width } #{y_position}"]
    end

    def create_table
    end

    #  params:
    #    row: examples:
    #           [{:content => "1x2", :rowspan => 2}, "C", "D", "E"],
    #           [{:content => "2x2", :colspan => 2, :rowspan => 2}, "F"],
    #           ["G", "H"]
    def table_row(row)
      @table = Array.new if @table.nil?
      @table.push row
    end

    # params:
    #   mark_extra_row, border_width: default values have no effect on table
    #   mark_extra_row == -1 => no background at all
    def push_table(mark_extra_row=0, border_width=-1)
      @data_array.push ["table #{ mark_extra_row } #{ border_width }", @table]
      @table = nil
    end

    def start_new_page
      @data_array.push ['new_page']
    end

    def get_headed_info(answer, amount_index)
      return '' if answer.nil?
      _header_ids = answer.template_field.header_ids.split('/')
      additional_info = TemplateField.find(_header_ids.first).document_answers.where(:document_id => @document_id).order(:id)[amount_index].answer
      additional_info += (" #{ TemplateField.find(_header_ids.last).document_answers.where(:document_id => @document_id).order(:id)[amount_index].answer }" if _header_ids.length > 1)

      additional_info
    end

    #Desc:   Should be invoced after each generating
    def finishing
      @data_array_enum = @data_array.to_enum
      self
    end
  end
end
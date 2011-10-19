class DataReader
  DELIMITERS = [' | ', ', ', ' ']

  def read *files
    data = []
    
    files.each do |file|
      delimiter = nil 
      file.each_line do |line|
        delimiter ||= find_delimiter line

        data << read_datum(line, delimiter)
      end 
    end

    data
  end

  private
  
    def read_datum line, delimiter
      fields = line.split delimiter

      case delimiter
      when DELIMITERS[0]
        read_pipe fields
      when DELIMITERS[1]
        read_comma fields
      when DELIMITERS[2]
        read_space fields
      end
    end

    def read_pipe fields
      drop_middle_initial fields
    end

    def read_comma fields
      fields
    end

    def read_space fields
      order(drop_middle_initial fields)
    end

    def drop_middle_initial fields
      last, first, middle, *rest = fields
      [last, first, *rest]
    end

    def order space_fields
      *rest, date, color = space_fields
      [*rest, color, date]
    end

    def find_delimiter line
      line =~ /^\w+(\W+)/
      (delimiter? $1) ? $1 : raise('Invalid delimiter') 
    end

    def delimiter? string
      DELIMITERS.include? string  
    end
end

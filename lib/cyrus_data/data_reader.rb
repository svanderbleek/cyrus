module CyrusData

  class DataReader

    class << self

      DELIMITERS = [' | ', ', ', ' ', "\t"]

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
            when DELIMITERS[3]
              read_tab(fields)
            end
        end

        def read_tab(fields)
          raise 'invalid data' if fields.size != 5
          swap_date_color fields
        end

        def read_pipe fields
          raise 'invalid data' if fields.size != 6
          swap_date_color(drop_middle_initial fields)
        end

        def read_comma fields
          raise 'invalid data' if fields.size != 5
          swap_date_color fields
        end

        def read_space fields
          raise 'invalid data' if fields.size != 6
          drop_middle_initial fields
        end

        def drop_middle_initial fields
          last, first, middle, *rest = fields
          [last, first, *rest]
        end

        def swap_date_color fields
          *rest, color, date = fields
          [*rest, date, color]
        end

        def find_delimiter line
          delimiter = line.match(/^\w+(\W+)/)[1]
          (delimiter? delimiter) ? delimiter : raise('Invalid delimiter')
        end

        def delimiter? string
          DELIMITERS.include? string  
        end

     end

  end

end

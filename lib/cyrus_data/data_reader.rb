module CyrusData

  class DataReader

    class << self

      DELIMITERS = ['|', ',', ' ', "\t"]

      def read *files
        data = []
        
        files.each do |file|
          delimiter = nil 
          file.each_line do |line|
            delimiters ||= find_delimiters line

            data << read_datum(line, delimiters)
          end 
        end

        data
      end

      private

        def read_datum line, delimiters
          delimiter = delimiters.first
          second_delimiter = delimiters[1]

          fields = line.split delimiter
          fields.map {|field| field.strip!}

          case delimiter
            when DELIMITERS[0]
              read_pipe fields, second_delimiter
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

      def read_pipe fields, second_delimiter
          fields = split_first_and_last_name(fields, second_delimiter) if second_delimiter

          raise 'invalid data' if fields.size != 6
          swap_date_color(drop_middle_initial fields)
      end

      def split_first_and_last_name fields, delimiter
        first_and_last_name = fields[0].split(delimiter)
        first_and_last_name + fields[1..fields.size]
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

      def remove_extra_space_delimiter(delimiters)
        delimiters.delete ' ' if delimiters.include?(' ') && (delimiters.size > 1)
      end

      def find_delimiters line
          delimiters = DELIMITERS.select do |delimiter|
              line.include? delimiter
          end

          remove_extra_space_delimiter(delimiters)

          delimiters
        end

        def delimiter? string
          DELIMITERS.include? string  
        end

     end

  end

end

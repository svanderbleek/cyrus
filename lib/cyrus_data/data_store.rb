require 'date'

module CyrusData

  class DataStore

    class Datum
      attr_reader :value

      def initialize fields
        @value = {
          :last_name      => fields[0],
          :first_name     => fields[1],
          :gender         => fields[2],
          :birthdate      => parse_date(fields[3]),
          :favorite_color => fields[4]
        }
      end

      def to_s
        [last_name, first_name, gender, format(birthdate), favorite_color].join(' ')
      end

      def method_missing method, *args, &block
        @value[method] 
      end

      private 
        def format birthdate
          birthdate.strftime('%m/%d/%Y')
        end

        def parse_date date
          if date =~ /-/
            Date.strptime date, '%m-%d-%Y'
          else
            Date.strptime date, '%m/%d/%Y'
          end
        end

    end

    attr_reader :data

    def initialize
      @data = []
    end

    def store *data
      data.each do |datum|
        @data << Datum.new(datum)
      end
    end

    def order_by *fields, order
      @data.sort! &(comparator fields)

      order == :ascending ? @data : @data.reverse!
    end

    private

      def comparator fields
        comparators = fields.map do |field|
          lambda {|a,b| a.send(field) <=> b.send(field)}
        end

        combine comparators
      end

      def combine comparators
        comparators.inject do |comparator1, comparator2|
          lambda do |a,b| 
            order = comparator1.call(a,b)
            order == 0 ? comparator2.call(a,b) : order
          end
        end
     end

  end

end

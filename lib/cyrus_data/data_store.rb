require 'date'

class DataStore

  class Datum
    attr_reader :value

    def initialize fields
      @value = {
        :last_name      => fields[0],
        :first_name     => fields[1],
        :gender         => fields[2],
        :birthdate      => format(fields[3]),
        :favorite_color => fields[4]
      }
    end

    def format date_field
      Date.parse(date_field).strftime('%m/%d/%Y') rescue raise 'bad date field'
    end

    def method_missing method, *args, &block
      @value[method] 
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
      fields.map do |field|
        if field == :birthdate
          lambda {|a,b| Date.parse(a.send(field)) <=> Date.parse(b.send(field))}
        else
          lambda {|a,b| a.send(field) <=> b.send(field)}
        end
      end.inject do |comparator1, comparator2|
        lambda do |a,b| 
          order = comparator1.call(a,b)
          order == 0 ? comparator2.call(a,b) : order
        end
      end
    end
      
end

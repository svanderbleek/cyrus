require 'date'

class DataStore

  class Datum
    attr_reader :value

    def initialize fields
      @value = {
        :last_name      => fields[0],
        :first_name     => fields[1],
        :gender         => fields[2],
        :birthdate      => format(fields[4]),
        :favorite_color => fields[3]
      }
    end

    def format date_field
      Date.parse(date).strftime('%m/%d/%Y')
    end

    def method_missing method, *args, &block
      @value[method] 
    end
  end

  attr_reader :data

  def initialize
    @data = []
  end

  def store datum
    @data << datum
  end

  def order_by order
    case order 

    when :gender_then_last_name_ascending
      comparator = lambda do |a,b|
        gender = a.gender <=> b.gender
        gender == 0 ? a.last_name <=> b.last_name : gender  
      end

    when :birthdate_ascending
      comparator = lambda {|a,b| a.birthdate <=> b.birthdate}

    when :last_name_descending
      comparator = lambda {|a,b| a.last_name <=> b.last_name }
    end

    @data.sort comparator
  end

end

require 'test/unit'
require 'date'
require 'cyrus_data/data_store'

module CyrusData

  class TestDataStore < Test::Unit::TestCase

    def setup
      @store = DataStore.new
    end

    def test_stores
      assert_equal 0, @store.data.size

      @store.store ['A', 'B', 'M', '1-1-1990', 'R']
      assert_equal 1, @store.data.size
    end

    def test_reads_dash_date
      @store.store ['A', 'B', 'M', '1-1-1990', 'R']
      assert_equal Date.parse('1-1-1990'), @store.data.first.birthdate
    end

    def test_reads_slash_date
      @store.store ['A', 'B', 'M', '1/1/1990', 'R']
      assert_equal Date.parse('1-1-1990'), @store.data.first.birthdate
    end

    def test_reads_date_by_month_day_year
      @store.store ['A', 'B', 'M', '1/13/1990', 'R']
      assert_equal Date.parse('13-1-1990'), @store.data.first.birthdate
    end    

    def test_datum_to_string
      @store.store ['A', 'B', 'M', '1-1-1990', 'R']
      assert_equal 'A B M 01/01/1990 R', @store.data.first.to_s
    end

    def test_orders_data_by_field
      @store.store ['D', 'B', 'M', '1-1-1990', 'R']
      @store.store ['A', 'B', 'M', '1-1-1990', 'R']
      assert_equal 'D', @store.data.first.last_name

      @store.order_by :last_name, :ascending
      assert_equal 'A', @store.data.first.last_name
    end

    def test_orders_data_by_fields
      @store.store ['D', 'B', 'M', '1-1-1980', 'R']
      @store.store ['B', 'B', 'M', '1-1-1980', 'R']
      @store.store ['A', 'B', 'M', '1-1-1990', 'R']
      assert_equal 'D', @store.data.first.last_name

      @store.order_by :birthdate, :last_name, :ascending
      assert_equal 'B', @store.data.first.last_name
    end

    def test_orders_data_descending
      @store.store ['A', 'B', 'M', '1-1-1990', 'R']
      @store.store ['D', 'B', 'M', '1-1-1990', 'R']
      assert_equal 'A', @store.data.first.last_name

      @store.order_by :last_name, :descending
      assert_equal 'D', @store.data.first.last_name
    end

  end

end

require 'test/unit'
require 'cyrus_data/data_store'

class TestDataStore < Test::Unit::TestCase

  def setup
    @store = DataStore.new
  end

  def test_stores
    assert_equal 0, @store.data.size

    @store.store ['A', 'B', 'M', '1-1-1990', 'R']
    assert_equal 1, @store.data.size
  end

  def test_formats_date
    @store.store ['A', 'B', 'M', '1-1-1990', 'R']
    assert_equal '01/01/1990', @store.data.first.birthdate
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

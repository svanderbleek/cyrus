require 'test/unit'
require 'cyrus_data/data_reader'

module CyrusData

  class TestDataReader < Test::Unit::TestCase

    def setup
      @reader = DataReader
    end

    def test_exception_for_bad_data
      bad = File.open 'test/fixtures/bad'
      assert_raise(RuntimeError) do
        @reader.read bad
      end
    end

    def test_exception_for_missing_fields
      tab_missing_gender = File.open 'test/fixtures/tab_missing_gender'
      assert_raise(RuntimeError) do
        @reader.read tab_missing_gender
      end
    end

    def test_reads_tab
      tab = File.open 'test/fixtures/tab'
      data = @reader.read tab

      assert_equal 3, data.size
      assert_equal 5, data.first.size
      assert_equal 'Peyton', data.first.first
    end


    def test_reads_comma
      comma = File.open 'test/fixtures/comma'
      data = @reader.read comma 

      assert_equal 3, data.size
      assert_equal 5, data.first.size
      assert_equal 'CLastName', data.first.first
    end

    def test_reads_space
      space = File.open 'test/fixtures/space'
      data = @reader.read space 

      assert_equal 2, data.size
      assert_equal 5, data.first.size
      assert_equal '10-12-2011', data.first[3]
    end

    def test_reads_pipe
      pipe  = File.open 'test/fixtures/pipe'
      data = @reader.read pipe 

      assert_equal 2, data.size
      assert_equal 5, data.first.size
      assert_equal 'BLastName', data.first.first
    end

    def test_reads_files
      pipe  = File.open 'test/fixtures/pipe'
      space = File.open 'test/fixtures/space'
      comma = File.open 'test/fixtures/comma'

      data = @reader.read pipe, space, comma
      assert_equal 7, data.size
    end

  end

end

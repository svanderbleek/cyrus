require 'test/unit'
require 'data_reader'

class TestDataReader < Test::Unit::TestCase

  def setup
    @reader = DataReader.new
  end

  def test_reads_comma
    comma = File.open 'test/fixtures/comma'
    data = @reader.read comma 
  end

  def test_reads_space
    space = File.open 'test/fixtures/space'
    data = @reader.read space 
  end

  def test_reads_pipe
    pipe  = File.open 'test/fixtures/pipe'
    data = @reader.read pipe 
    assert_equal(2, data.size)
    assert_equal('BLastName', data.first.last_name)
  end

end

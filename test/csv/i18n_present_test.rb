require 'test_helper'

class CSVI18nPresentTest < Minitest::Test
  # A mock of the I18n class for testing translations
  class FakeI18n
    def self.translate(key, options = {})
      "#{key} #{options[:line_number]}"
    end
  end

  def setup
    Object.send(:const_set, :I18n, FakeI18n)
  end

  def teardown
    Object.send(:remove_const, :I18n)
  end

  def test_it_translates_the_unquoted_field_error_with_line_number
    error = assert_raises CSV::MalformedCSVError do
      CSV.parse('"')
    end

    assert_equal 'unclosed_quoted_field 1', error.message
  end

  def test_it_translates_the_field_size_limit_error
    error = assert_raises CSV::MalformedCSVError do
      CSV.parse("\"\n\"", field_size_limit: 1)
    end

    assert_equal 'field_size_exceeded 1', error.message
  end

  def test_it_translates_the_illegal_quoting_error
    error = assert_raises CSV::MalformedCSVError do
      CSV.parse('a"b"c')
    end

    assert_equal 'illegal_quoting 1', error.message
  end

  def test_it_translates_the_unquoted_fields_do_not_allow_r_or_n_error
    error = assert_raises CSV::MalformedCSVError do
      CSV.parse("a,b\rc,d\na,bc,d")
    end

    assert_equal 'unquoted_fields_do_not_allow_r_or_n 2', error.message
  end

  def test_it_translates_the_missing_or_stray_quote_error
    error = assert_raises CSV::MalformedCSVError do
      CSV.parse("\"a\"b\"\"")
    end

    assert_equal 'missing_or_stray_quote 1', error.message
  end
end

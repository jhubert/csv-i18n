require 'test_helper'

class CSVI18nMissingTest < Minitest::Test
  def test_it_returns_default_error_message_when_i18n_does_not_exist
    error = assert_raises CSV::MalformedCSVError do
      CSV.parse('"', encoding: 'utf-8')
    end

    assert_equal "Unclosed quoted field on line 1.", error.message
  end
end

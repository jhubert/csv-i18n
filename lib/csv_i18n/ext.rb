module CSVI18n
  module Ext
    # Redefine the shift method to catch the exception and attempt to return
    # a translated version of the error message using I18n.t
    def shift
      super
    rescue ::CSV::MalformedCSVError => exception
      raise $!, translated_exception_message(exception.message), $!.backtrace
    end

    private

    # Parse the exception message and attempt to translate it. If no translation
    # is possible, simply return the original error message.
    #
    # The translation keys need to be defined in your language files as follows.
    #
    #  csv:
    #    exception:
    #      field_size_exceeded: "Broken on %{line_number}"
    #      illegal_quoting:
    #      missing_or_stray_quote:
    #      unclosed_quoted_field:
    #      unquoted_fields_do_not_allow_r_or_n:
    #
    def translated_exception_message(msg)
      return msg unless translatable?

      # This will break if the CSV class changes it's error messages
      matches = msg.match(/\s[ion]{2}?\s?\(?line (\d)\)?\.?/i)
      return msg if matches.nil?

      ::I18n.translate(
        keyify(msg.sub(matches[0], '')),
        scope: [:csv, :exception],
        line_number: matches[1],
        default: msg
      )
    end

    # :reek:UtilityFunction for readability
    def translatable?
      defined?(::I18n) && ::I18n.locale_available?(::I18n.locale)
    end

    # :reek:UtilityFunction but could use parameterize('_') if rails is present
    def keyify(msg)
      msg.gsub(/[^a-z]+/i, ' ').strip.gsub(' ', '_').downcase
    end
  end
end

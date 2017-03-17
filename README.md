# CSV::I18n

[![Build Status](https://travis-ci.org/jhubert/csv-i18n.svg?branch=master)](https://travis-ci.org/jhubert/csv-i18n)

This gem makes it possible to translate the parsing error messages returned from the CSV core module using the [I18n](https://github.com/svenfuchs/i18n) library.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'csv-i18n'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install csv-i18n

## Usage

Here is a very basic example:

```ruby
require 'csv'
require 'csv-i18n'
require 'i18n'

I18n.backend.store_translations(:en, csv: { exception: { unclosed_quoted_field: "custom error on line %{line_number}" } })

CSV.parse('"')
# lib/ruby/2.3.0/csv.rb:1898:in `block in shift': custom error on line 1 (CSV::MalformedCSVError)
#   from lib/ruby/2.3.0/csv.rb:1805:in `loop'
#   from lib/ruby/2.3.0/csv.rb:1805:in `shift'
#   from lib/ruby/gems/2.3.0/gems/csv-i18n-0.1.1/lib/csv_i18n/ext.rb:6:in `shift'
#   from lib/ruby/2.3.0/csv.rb:1747:in `each'
#   from lib/ruby/2.3.0/csv.rb:1761:in `to_a'
#   from lib/ruby/2.3.0/csv.rb:1761:in `read'
#   from lib/ruby/2.3.0/csv.rb:1307:in `parse'
#   from app.rb:7:in `<main>'
```

The library is not dependent on I18n, so you can include it before you start internationalizing your code. If I18n isn't found, it will just fall back to the default error messages. Same behavior if a translation or locale isn't found.

### Translations

Once you have installed the gem, you can add your translations to the language files like this:

```yaml
csv:
  exception:
    field_size_exceeded: "Broken on %{line_number}"
    illegal_quoting: "Illegal quoting in line %{line_number}"
    missing_or_stray_quote: "Missing or stray quote in line %{line_number}"
    unclosed_quoted_field: "Unclosed quoted field on line %{line_number}."
    unquoted_fields_do_not_allow_r_or_n: "Unquoted fields do not allow \\r or \\n (line #{line_number})."
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jhubert/csv-i18n.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


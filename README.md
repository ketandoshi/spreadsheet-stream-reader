# SpreadsheetStreamReader

Memory efficient spreadsheet reader. It reads file in streaming fashion. Currently supports Excel legacy file (.xls) format. Work in progress for other file formats.

You can configure the batch size. It will read and streams the batch size rows at a time.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'spreadsheet_stream_reader'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install spreadsheet_stream_reader

## Usage

#### Opening a spreadsheet

```ruby
require 'spreadsheet_stream_reader'

records_per_batch = 100 #By default its 1000. You will get this much records at a time.

document = SpreadsheetStreamReader::Reader.new('/path/to/workbook.xls', records_per_batch)
```

#### Working with sheets

```ruby
# Returns an array of names of sheets present in the workbook
document.sheet_names
# => ["K-Sheet-1", "K-Sheet-22"]


## Access the sheet
# By name
sheet1 = document.get_sheet('K-Sheet-1')
# By index
sheet2 = document.get_sheet(1)

# => Returns the SpreadsheetStreamReader::Sheet object
```

#### Iterate through single sheet

```ruby
sheet1.stream_rows_in_batch do |row|
  puts row #Work with the row data
end
```

#### Iterate through workbook (all sheets in workbook)

```ruby
document.each_sheet do |sheet|
  sheet.stream_rows_in_batch do |row|
    puts row #Work with the row data
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ketandoshi/spreadsheet-stream-reader. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the SpreadsheetStreamReader project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ketandoshi/spreadsheet-stream-reader/blob/master/CODE_OF_CONDUCT.md).

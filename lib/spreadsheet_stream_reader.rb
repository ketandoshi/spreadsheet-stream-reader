require 'spreadsheet_stream_reader/version'
require 'spreadsheet_stream_reader/book_reader'
require 'spreadsheet_stream_reader/sheet'

module SpreadsheetStreamReader
  class InvalidParameterError < StandardError; end

  class Reader
    attr_accessor :file_path, :batch_size, :data

    VALID_FILE_EXTS = %w(.xls)

    def initialize(file_path, batch_size = 1000)
      raise InvalidParameterError,
            "File extension should be one of the: #{VALID_FILE_EXTS}" unless VALID_FILE_EXTS.include?(File.extname(file_path.to_s))

      self.file_path = file_path.to_s
      self.batch_size = batch_size
      self.data = Array.new
    end

    def sheet_names
      sheets.collect{|s| s.name}
    end

    def get_sheet(idx_or_name)
      Sheet.new(book_reader.get_work_sheet(idx_or_name), @batch_size)
    end

    def each_sheet
      sheet_names.each do |name|
        yield get_sheet(name)
      end
    end

    private

    def book
      @book ||= book_reader.open_book
    end

    def sheets
      @work_sheets ||= book_reader.get_work_sheets
    end

    def book_reader
      @book_reader ||= BookReader.new(@file_path)
    end
  end

end
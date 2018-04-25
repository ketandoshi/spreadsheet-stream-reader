require 'spreadsheet'

module SpreadsheetStreamReader

  class BookReader
    attr_accessor :file_path, :file_ext

    def initialize(file_path)
      self.file_path = file_path.to_s
      self.file_ext = File.extname(file_path.to_s).downcase
    end

    def open_book
      @open_book ||= case @file_ext
        when '.xls'
          Spreadsheet.open(@file_path)
        else
          nil
      end
    end

    def get_work_sheets
      open_book.worksheets
    end

    def get_work_sheet(idx_or_name)
      open_book.worksheet(idx_or_name)
    end
  end

end
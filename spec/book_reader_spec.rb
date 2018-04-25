require "spec_helper"

RSpec.describe SpreadsheetStreamReader::BookReader do
  before(:all) do
    @file_path = 'spec/fixtures/xls-files/test-file.xls'
    @book_reader = described_class.new(@file_path)
  end

  describe '.new' do
    it 'sets the file path' do
      expect(@book_reader.file_path).to eq(@file_path)
    end

    it 'sets the file extension' do
      expect(@book_reader.file_ext).to eq(File.extname(@file_path).downcase)
    end
  end

  describe '.open_book' do
    context 'open the workbook with proper extension' do
      it 'returns the Spreadsheet::Excel::Workbook book' do
        expect(@book_reader.open_book).to be_instance_of(Spreadsheet::Excel::Workbook)
      end
    end

    context 'open the workbook with no extension' do
      it 'returns nil' do
        expect(described_class.new('spec/fixtures/xls-files/test-file-without-ext').open_book).to be_nil
      end
    end
  end
end
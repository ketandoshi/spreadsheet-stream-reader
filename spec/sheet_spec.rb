require "spec_helper"

RSpec.describe SpreadsheetStreamReader::Sheet do
  before(:all) do
    @file_path = 'spec/fixtures/xls-files/test-file.xls'
    @batch_size = 10
    @document = SpreadsheetStreamReader::Reader.new(@file_path, @batch_size)
    @sheet = @document.get_sheet(0)
  end

  describe '.new' do
    it 'sets the provided batch size' do
      expect(@sheet.batch_size).to eq(@batch_size)
    end

    it 'checks the default value for offset, counter and data' do
      expect(@sheet.offset).to eq(1)
      expect(@sheet.counter).to eq(0)
      expect(@sheet.data).to eq(Array.new)
    end

    it 'w_sheet should have sheet object' do
      expect(@sheet.w_sheet).to be_instance_of(Spreadsheet::Excel::Worksheet)
    end
  end

  describe '.stream_rows_in_batch' do
    context 'providing block' do
      it 'iterates through all the rows' do
        expect {
          @sheet.stream_rows_in_batch do |row|
            row
          end
        }.to_not raise_exception
      end
    end

    context 'without providing block' do
      it 'returns the data' do
        expect(@sheet.stream_rows_in_batch).not_to be_nil
        expect(@sheet.stream_rows_in_batch).to be_instance_of(Array)
      end
    end
  end
end
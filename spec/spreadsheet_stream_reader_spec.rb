require "spec_helper"

RSpec.describe SpreadsheetStreamReader::Reader do
  before(:all) do
    @file_path = 'spec/fixtures/xls-files/test-file.xls'
    @batch_size = 10
    @document = described_class.new(@file_path, @batch_size)
  end

  it "has a version number" do
    expect(SpreadsheetStreamReader::VERSION).not_to be nil
  end

  context 'Constants' do
    context 'VALID_FILE_EXTS' do
      it 'is an array' do
        expect(described_class::VALID_FILE_EXTS).to be_instance_of(Array)
      end

      it 'returns all valid file extensions' do
        expect(described_class::VALID_FILE_EXTS).to eq(['.xls'])
      end
    end
  end

  context 'initialization' do
    context 'file validation' do
      context 'validates the file extension' do
        let(:file_path) { 'fixtures/xls-files/test-file-without-ext' }

        it 'raises an exception for InvalidParameterError' do
          expect { described_class.new(file_path) }
            .to raise_exception(SpreadsheetStreamReader::InvalidParameterError, "File extension should be one of the: #{described_class::VALID_FILE_EXTS}")
        end
      end
    end
  end

  describe '.new' do
    it 'creates a reader instance' do
      expect(@document).to be_instance_of(described_class)
    end

    it 'sets the file path as given' do
      expect(@document.file_path).to eq(@file_path)
    end

    it 'sets the batch size as given' do
      expect(@document.batch_size).to eq(@batch_size)
    end

    it 'initially the data should be empty' do
      expect(@document.data).to eq(Array.new)
    end
  end

  describe '.sheet_names' do
    it 'provides the array of name of all the sheets in workbook' do
      expect(@document.sheet_names).to be_instance_of(Array)
      expect(@document.sheet_names).not_to be_nil
    end
  end

  describe '.get_sheet' do
    context 'For existing sheet' do
      let(:sheet_obj) { @document.get_sheet(@document.sheet_names.first) }

      it 'returns the SpreadsheetStreamReader::Sheet object' do
        expect(sheet_obj).to be_instance_of(SpreadsheetStreamReader::Sheet)
      end

      it 'the sheet should be present' do
        expect(sheet_obj.w_sheet).not_to be_nil
        expect(sheet_obj.w_sheet).to be_instance_of(Spreadsheet::Excel::Worksheet)
      end
    end

    context 'For non existing sheet' do
      let(:sheet_obj) { @document.get_sheet(@document.sheet_names.size+1) }

      it 'returns the SpreadsheetStreamReader::Sheet object' do
        expect(sheet_obj).to be_instance_of(SpreadsheetStreamReader::Sheet)
      end

      it 'the sheet should not be present' do
        expect(sheet_obj.w_sheet).to be_nil
      end
    end
  end

  describe '.each_sheet' do
    context 'Streams data from all the sheet with records in a workbook' do
      it 'iterates through all the sheet' do
        expect {
          @document.each_sheet do |sheet|
            sheet.class
          end
        }.to_not raise_exception
      end
    end

    context 'Streams data from all the sheet with no records in a workbook' do
      let(:reader_obj) { described_class.new('fixtures/xls-files/test-file-no-records.xls') }

      it 'iterates through all the sheet but no data present' do
        expect {
          @document.each_sheet do |sheet|
            sheet.class
          end
        }.to_not raise_exception
      end
    end
  end

end
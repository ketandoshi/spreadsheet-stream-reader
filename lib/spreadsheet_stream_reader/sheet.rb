module SpreadsheetStreamReader

  class Sheet
    attr_accessor :batch_size, :offset, :counter, :data, :w_sheet

    def initialize(_sheet, batch_size = 1000)
      self.batch_size = batch_size
      self.offset = 1
      self.counter = 0
      self.data = Array.new
      self.w_sheet = _sheet
    end

    def stream_rows_in_batch
      if block_given?
        while offset < max_record
          get_content_in_chunks

          @data.each do |row|
            yield row
          end

          increment_offset
        end
      else
        get_content_in_chunks
        increment_offset
        @data
      end
    end

    def get_content_in_chunks
      clear_data

      sheet.each @offset do |row|
        increment_counter
        @data << row[0..(row.size - 1)]
        break if reached_batch_size? || reached_end_of_file?
      end
    end

    private

    def sheet
      @w_sheet
    end

    def max_record
      @max_record ||= sheet.last_row_index
    end

    def increment_counter
      @counter += 1
    end

    def increment_offset
      @offset += @batch_size
    end

    def reached_batch_size?
      (counter % @batch_size).zero?
    end

    def reached_end_of_file?
      counter == max_record
    end

    def clear_data
      @data.clear
    end
  end

end
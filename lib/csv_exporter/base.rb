require 'active_support/all'
require 'active_support/core_ext/hash'

module CsvExporter
  class Base

    def csv_file(collection, hash, filename)
      CSV.open(CsvExporter.file(filename), 'w') do |csv|

        collection.each_with_index do |element, index|

          case element.class.to_s.downcase
          when 'hash'
            csv << element.keys if index == 0
            csv << element.values
          when 'array'
            csv << element
          when 'openstruct'
            csv << element.to_h.keys.map(&:capitalize) if index == 0
            csv << element.to_h.values
          else
            if hash.is_a?(Hash)
              hash.symbolize_keys!
              if hash[:export_fields].present?
                csv << hash[:export_fields].map(&:capitalize) if index == 0
                csv << custom_rows(element, hash[:export_fields])
              else
                csv << hash.keys.map(&:capitalize) if index == 0
                csv << custom_rows(element, hash.values)
              end
            elsif hash.is_a?(Array)
              csv << hash.map(&:capitalize) if index == 0
              csv << custom_rows(element, hash)
            end
          end

        end

      end
    end

    private

    def custom_rows(element, hash)
      hash.map do |v|
        element.send(v)
      end
    end

  end
end

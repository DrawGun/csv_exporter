class Array

  def csv_export(hash = {}, filename = nil)
    exporter = CsvExporter::Base.new
    exporter.csv_file(self, hash, filename)
  end

end

require 'yaml'
require 'csv'
require 'csv_exporter/core_ext/array'
require 'csv_exporter/base'

module CsvExporter
  class RuntimeError < RuntimeError ; end
  class NotFound < RuntimeError ; end

  class << self

    def load(file, env = nil)
      @environment = env.to_s if env
      config = YAML.load_file(file)
      @configuration = defined?(@environment) ? config[@environment] : config
    end

    def configuration
      @configuration
    end

    def file(filename = nil)
      file_hash = if configuration
        { path: configuration['filepath'], name: filename || configuration['filename'] }
      else
        { path: 'tmp', name: file || 'file.csv' }
      end

      File.join(root, file_hash[:path], file_hash[:name])
    end

    def root
      defined?(Rails) ? Rails.root : File.expand_path("../.." , __FILE__)
    end

  end

end

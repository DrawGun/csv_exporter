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
      if defined? @environment
        raise RuntimeError.new("not configured CsvExporter for #{@environment} enviroment") unless @configuration
      else
        raise RuntimeError.new('not configured CsvExporter') unless @configuration
      end

      @configuration
    end

    def environment
      @environment
    end

    def file(filename = nil)
      filename ||= configuration['filename']
      File.join(root, configuration['filepath'], filename)
    end

    def root
      defined?(Rails) ? Rails.root : File.expand_path("../.." , __FILE__)
    end

  end

end

require 'spec_helper'
require 'csv'
require 'ostruct'
require 'active_record'
require 'pry'


describe CsvExporter do

  before do
    described_class.load(File.join(File.dirname(__FILE__), '..', 'examples/csv_exporter.yml'), :test)
  end

  context 'Expands an' do

    it 'array of hashes' do
      [
        { first: 1, second: 2, third: 3 },
        { first: 4, second: 5, third: 6 },
        { first: 'a', second: 'b', third: 'c' }
      ].csv_export

      expected_csv = CSV.read(CsvExporter.file)
      expect(expected_csv.first).to eq(['first', 'second', 'third'])
    end

    it 'array of arrays' do
      [
        ['Name', 'Age', 'Sex'],
        ['Mike', 23, 'M'],
        ['Helga', 26, 'F']
      ].csv_export

      expected_csv = CSV.read(CsvExporter.file)
      expect(expected_csv.last).to eq(['Helga', '26', 'F'])
    end

    it 'array of objects' do
      [
        OpenStruct.new(name: 'Mike', age: 23, sex: 'M'),
        OpenStruct.new(name: 'Helga', age: 26, sex: 'F'),
        OpenStruct.new(name: 'Bane', age: 23, sex: 'M')
      ].csv_export

      expected_csv = CSV.read(CsvExporter.file)
      expect(expected_csv.first).to eq(['Name', 'Age', 'Sex'])
    end

    context 'array of classes' do

      before do

        class Zombie

          def initialize(opts)
            @name = opts[:name]
            @age = opts[:age]
            @status = opts[:status]
          end

          def name
            @name
          end

          def age
            @age
          end

          def status
            @status
          end

          def custom_method
            "TEST: #{name} #{age} #{status}"
          end

        end

        @z1 = Zombie.new(name: 'Mark', age: 23, status: 'dead')
        @z2 = Zombie.new(name: 'Helga', age: 26, status: 'dead')
        @z3 = Zombie.new(name: 'Henry', age: 40, status: 'dead')

      end

      it 'and return only hash fields' do
        [ @z1, @z2, @z3 ].csv_export('Zombie name' => :name, 'Zombie status' => :status)
        expected_csv = CSV.read(CsvExporter.file)
        expect(expected_csv.first).to eq(['Zombie name', 'Zombie status'])
      end

      it 'and return only hash fields (alternative)' do
        [ @z1, @z2, @z3 ].csv_export('export_fields' => [:name, :status])
        expected_csv = CSV.read(CsvExporter.file)
        expect(expected_csv.first).to eq(['Name', 'Status'])
      end

      it 'and return only hash fields (alternative)' do
        [ @z1, @z2, @z3 ].csv_export(export_fields: [:name, :status])
        expected_csv = CSV.read(CsvExporter.file)
        expect(expected_csv.first).to eq(['Name', 'Status'])
      end

      it 'and return only array fields' do
        [ @z1, @z2, @z3 ].csv_export([:name, :status])
        expected_csv = CSV.read(CsvExporter.file)
        expect(expected_csv.first).to eq(['Name', 'Status'])
      end

      it 'and can return custom fields' do
        [ @z1, @z2, @z3 ].csv_export('Zombie name' => :name, 'Zombie status' => :status, 'Custom' => :custom_method)
        expected_csv = CSV.read(CsvExporter.file)
        expect(expected_csv.last).to eq(['Henry', 'dead', 'TEST: Henry 40 dead'])
      end

    end

  end

end

module Importer
  # Import a csv file with one work per row. The first row of the csv should be a
  # header row. The model for each row can either be specified in a column called
  # 'type' or globally by passing the model attribute
  class CSVImporter

    attr_reader :checksum_file, :depositor, :files_directory, :manifest_file, :model, :on_behalf_of

    # @param [String] manifest_file path to CSV file
    # @param [String] files_directory path, passed to factory constructor
    # @param [String] checksum_file path to checksum file
    # @param [String] depositor user_key of the User performing the deposit
    # @param [#to_s, Class] model if Class, the factory class to be invoked per row.
    # Otherwise, the stringable first (Xxx) portion of an "XxxFactory" constant.
    # @param [String] on_behalf_of user_key of the User on whose behalf the deposit is being made (if proxy deposit)
    def initialize(manifest_file,
                   files_directory,
                   model: nil,
                   checksum_file: nil,
                   depositor: nil,
                   on_behalf_of: nil)
      @manifest_file = manifest_file
      @files_directory = files_directory
      @checksum_file = checksum_file
      @depositor = depositor
      @model = model
      @on_behalf_of = on_behalf_of
    end

    # @return [Integer] count of objects created
    def import_all
      load_checksums if checksum_file
      count = 0
      parser.each do |attributes|
        attrs = attributes.merge(deposit_attributes)
        create_fedora_objects(attrs)
        count += 1
      end
      count
    end

    private

    def deposit_attributes
      { depositor: depositor, on_behalf_of: on_behalf_of }
    end

    def parser
      CSVParser.new(manifest_file)
    end

    # @return [Class] the model class to be used
    def factory_class(model)
      return model if model.is_a?(Class)
      if model.empty?
        $stderr.puts 'ERROR: No model was specified'
        exit(1) # rubocop:disable Rails/Exit
      end
      return Factory.for(model.to_s) if model.respond_to?(:to_s)
      raise "Unrecognized model type: #{model.class}"
    end

    # Build a factory to create the objects in fedora.
    # @param [Hash<Symbol => String>] attributes
    # @option attributes [String] :type overrides model for a single object
    # @note remaining attributes are passed to factory constructor
    def create_fedora_objects(attributes)
      factory_class(attributes.delete(:type) || model).new(attributes, files_directory).run
    end

    def load_checksums
      Checksum.import_data(checksum_file)
    end

  end
end

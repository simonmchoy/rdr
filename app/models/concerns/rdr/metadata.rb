module Rdr
  module Metadata
    extend ActiveSupport::Concern

    included do
      property :alternative, predicate: ::RDF::Vocab::DC.alternative do |index|
        index.as :stored_searchable
      end

      property :affiliation, predicate: ::RDF::URI.new("http://repository.lib.duke.edu/vocab/asset/affiliation") do |index|
        index.as :stored_searchable, :facetable
      end

      property :available, predicate: ::RDF::Vocab::DC.available do |index|
        index.as :dateable
      end

      property :temporal, predicate: ::RDF::Vocab::DC.temporal do |index|
        index.as :dateable
      end

      property :format, predicate: ::RDF::Vocab::DC.format do |index|
        index.as :stored_searchable, :facetable
      end

      property :is_replaced_by, predicate: ::RDF::Vocab::DC.isReplacedBy do |index|
        index.as :symbol
      end

      property :provenance, predicate: ::RDF::Vocab::DC.provenance do |index|
        index.as :stored_searchable
      end

      property :replaces, predicate: ::RDF::Vocab::DC.replaces do |index|
        index.as :symbol
      end

      property :rights_note, predicate: ::RDF::URI.new("http://repository.lib.duke.edu/vocab/asset/rightsNote") do |index|
        index.as :stored_searchable
      end

      property :doi, predicate: ::RDF::Vocab::Identifiers.doi do |index|
        index.as :stored_sortable
      end

      property :ark, predicate: ::RDF::URI.new("http://repository.lib.duke.edu/vocab/asset/ark") do |index|
        index.as :stored_sortable
      end
    end

  end
end

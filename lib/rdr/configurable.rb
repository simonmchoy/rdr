module Rdr
  module Configurable
    extend ActiveSupport::Concern

    included do

      # reason recorded in Ezid when an ARK is made unavailable due to object deaccession
      mattr_accessor :deaccession_reason do
        ENV["DEACCESSION_REASON"] || 'Deaccessioned from repository'
      end

      # default from address for emails sent by application
      mattr_accessor :default_from_address do
        ENV["DEFAULT_FROM_ADDRESS"] || 'from@example.com'
      end

      # URL of depositor modification request form
      mattr_accessor :depositor_request_form do
        ENV["DEPOSITOR_REQUEST_FORM"]
      end

      # Base URL for export files - include trailing slash
      mattr_accessor :export_files_base_url do
        ENV["EXPORT_FILES_BASE_URL"] || "/export_files/"
      end

      # Contact email for export files
      mattr_accessor :export_files_contact_email do
        ENV["EXPORT_FILES_CONTACT_EMAIL"] || 'from@example.com'
      end

      mattr_accessor :export_files_max_payload_size do
        if value = ENV["EXPORT_FILES_MAX_PAYLOAD_SIZE"]
          value.to_i
        else
          100 * 10**9 # 100Gb
        end
      end

      # Directory to store export files
      mattr_accessor :export_files_store do
        ENV["EXPORT_FILES_STORE"] || File.join(Rails.root, "public", "export_files")
      end

      # Source-Organization for export files bag info
      mattr_accessor :export_files_source_organization do
        ENV["EXPORT_FILES_SOURCE_ORGANIZATION"] || 'Duke University Libraries'
      end

      # Host name for use in non-web-request situations
      mattr_accessor :host_name do
        ENV["HOST_NAME"]
      end

      # ID of AdminSet to use unless otherwise specified
      mattr_accessor :preferred_admin_set_id

      # Crossref login_id
      mattr_accessor :crossref_user do
        ENV["CROSSREF_USER"] || "NOT_SET"
      end

      # Crossref login_password
      mattr_accessor :crossref_password do
        ENV["CROSSREF_PASSWORD"] || "NOT_SET"
      end

      # Crossref registration host
      mattr_accessor :crossref_host do
        ENV["CROSSREF_HOST"] || "test.crossref.org"
      end

      # Geonames user account
      mattr_accessor :geonames_user do
        ENV["GEONAMES_USER"] || "NOT_SET"
      end

      # The point at which to truncate the display of the description field in index views
      mattr_accessor :description_truncation_length_index_view do
        if ENV["DESCRIPTION_TRUNCATION_LENGTH_INDEX_VIEW"].present?
          ENV["DESCRIPTION_TRUNCATION_LENGTH_INDEX_VIEW"].to_i
        else
          250
        end
      end

    end

    module ClassMethods
      def configure
        yield self
      end
    end

  end
end

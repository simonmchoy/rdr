# Generated via
#  `rails generate hyrax:work Dataset`
module Hyrax
  class DatasetPresenter < Hyrax::WorkShowPresenter
    # Account for fields not already delegated to solr_document via
    # https://github.com/samvera/hyrax/blob/master/app/presenters/hyrax/work_show_presenter.rb
    delegate  :affiliation, :alternative, :ark, :available, :based_near,
              :bibliographic_citation, :doi, :format, :provenance,
              :related_url, :resource_type, :temporal, to: :solr_document
  end
end

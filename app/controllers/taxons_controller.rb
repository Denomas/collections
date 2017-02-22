class TaxonsController < ApplicationController
  before_action :return_404, unless: :new_navigation_enabled?

  def show
    setup_content_item_and_navigation_helpers(taxon)

    dimension = Rails.application.config.navigation_ab_test_dimension
    ab_test = GovukAbTesting::AbTest.new("EducationNavigation", dimension: dimension)
    ab_variant = ab_test.requested_variant(request)

    ab_variant.configure_response(response)

    # Show the taxon page regardless of which variant is requested, because
    # there is no straighforward mapping of taxons back to original navigation
    # pages.
    render :show, locals: { taxon: taxon, ab_variant: ab_variant }
  end

private

  def return_404
    head :not_found
  end

  def taxon
    @taxon ||= Taxon.find(request.path)
  end
end
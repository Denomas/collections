class Subcategory
  def self.find(slug)
    collections_api = Collections.services(:collections_api)

    if collections_api_response = collections_api.curated_lists_for("/#{slug}")
      new(collections_api_response)
    else
      nil
    end
  end

  def initialize(curated_content)
    @curated_content = curated_content
  end

  def content
    details.groups
  end

  def description
    curated_content.description
  end

  def parent_sector
    curated_content.parent
  end

  def parent_sector_title
    parent_sector.title
  end

  def title
    curated_content.title
  end

private

  attr_reader :curated_content

  def details
    curated_content.details
  end
end
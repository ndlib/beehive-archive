class CollectionRedirect
  attr_reader :collection_id

  def self.call(collection_id)
    new(collection_id).find_and_redirect
  end

  def initialize(collection_id)
    @collection_id = collection_id
  end

  def find_and_redirect
    @exhibit = Exhibit.find_by(collection_id:  collection_id)
    if @exhibit
      exhibit_path @exhibit
    else
      new_exhibit_path
    end
  end

  private

  def new_exhibit_path
    h.new_exhibit_path(collection_id: collection_id)
  end

  def exhibit_path(id)
    h.exhibit_showcases_path(id)
  end

  def h
    Rails.application.routes.url_helpers
  end
end

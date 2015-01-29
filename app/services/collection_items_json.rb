class CollectionItemsJson
  attr_reader :exhibit

  def initialize(exhibit)
    @exhibit = exhibit
  end

  def items_json
    get_json(items_json_url)
  end

  def item_json(item_id)
    get_json(item_json_url(item_id))
  end

  private
    def collection_id
      exhibit.collection_id
    end

    def last_response
      @last_response
    end

    def get_json(url)
      if response = get_request(url)
        response.body.with_indifferent_access
      else
        nil
      end
    end

    def get_request(url)
      @last_response = connection.get(url)
      if @last_response.success?
        @last_response
      else
        false
      end
    end

    def connection
      @connection ||= Faraday.new(api_url) do |f|
        f.request :multipart
        f.request :url_encoded
        f.adapter :net_http
        f.response :json, :content_type => 'application/json'
      end
    end

    def items_json_url
      "/api/collections/#{collection_id}/items.json?include=image"
    end

    def item_json_url(item_id)
      "/api/collections/#{collection_id}/items/#{item_id}.json?include=image"
    end

    def api_url
      Rails.configuration.honeycomb_url
    end

end

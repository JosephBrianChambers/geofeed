module Instagram
  class ApiClient
    VERSION = "v1"
    HOST = "https://api.instagram.com"

    def locations_search(lat:, lng:, distance:)
      params = { lat: lat, lng: lng, distance: distance }
      query_string = params.merge(access_token: "foobar").to_query
      url = "#{HOST}/#{VERSION}/locations/search?#{query_string}"
      response = connection(url).get
      JSON.parse(response.body)
    end

    def location_media(location_id:)
      query_string = { access_token: "foobar" }.to_query
      url = "#{HOST}/#{VERSION}/locations/#{location_id}/media/recent?#{query_string}"
      response = connection(url).get
      JSON.parse(response.body)
    end

    private

    def connection(url)
      Faraday.new(url: url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to $stdout
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end

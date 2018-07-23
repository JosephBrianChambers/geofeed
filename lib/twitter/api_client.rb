module Twitter
  class ApiClient
    VERSION = "1.1"
    HOST = "https://api.twitter.com"
    AUTHORIZATION_HEADER = "Bearer #{Rails.application.secrets.twitter_app_bearer_token}"

    def search_tweets(options)
      params = {
        result_type: "recent",
        count: options[:count] || 100,
        include_entities: true,
        geocode: (values = options.values_at(:lat, :lng, :radius_km)).all?(&:present?) ? values.join(",") + "km" : nil,
        q: CGI.escape(options[:q].to_s),
        since_id: options[:since_id],
        max_id: options[:max_id],
      }.compact

      response = connection("#{HOST}/#{VERSION}/search/tweets.json?#{params.to_query}").get do |req|
        req.headers["Authorization"] = "Bearer #{Rails.application.secrets.twitter_app_bearer_token}"
      end

      JSON.parse(response.body)
    end

    # TODO: implement better logging & and bad request capturing
    def search_query(query_parameters_string)
      url = "#{HOST}/#{VERSION}/search/tweets.json#{query_parameters_string}"

      response = connection(url).get do |req|
        req.headers["Authorization"] = AUTHORIZATION_HEADER
      end

      raise RuntimeError, response unless response.status == 200

      JSON.parse(response.body)
    end

    private

    def oauth2_token
      url = "#{HOST}/oauth2/token"
      key = Rails.application.secrets.twitter_consumer_key
      secret = Rails.application.secrets.twitter_consumer_secret
      auth_string = Base64.encode64("#{key}:#{secret}").gsub(/\s/, "")

      response = connection(url).post do |req|
        req.headers["Authorization"] = "Basic #{auth_string}"
        req.headers["Content-Type"] = "application/x-www-form-urlencoded;charset=UTF-8"
        req.body = "grant_type=client_credentials"
      end
    end

    def connection(url)
      Faraday.new(url: url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to $stdout
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end
  end
end

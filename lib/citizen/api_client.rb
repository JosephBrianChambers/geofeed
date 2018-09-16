module Citizen
  class ApiClient
    VERSION = "V2"
    HOST = "api.sp0n.io"

    def incidents_nearby(options)
      request_body = {
        "cityCode": "sv",
        "fullResponse": true,
        "lowerLatitude": options[:lowerLatitude],
        "lowerLongitude": options[:lowerLongitude],
        "offset": 0,
        "upperLatitude": options[:upperLatitude],
        "upperLongitude": options[:upperLongitude],
      }

      url = "https://#{HOST}/#{VERSION}/api/incident/nearby"

      response = connection(url).post do |req|
        req.headers["x-access-token"] = Rails.application.secrets.citizen_x_access_token
        req.headers["Content-Type"] = "application/json"
        req.body = request_body.to_json
      end

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

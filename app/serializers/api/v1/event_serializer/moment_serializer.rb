class Api::V1::EventSerializer::MomentSerializer < ActiveModel::Serializer
  attributes :id, :geojson_feature

  def geojson_feature
    {
      type: "Feature",
      geometry: object.geojson,
      properties: {
        id: object.id,
        content_provider_code: object.content_provider.code
      }
    }
  end
end

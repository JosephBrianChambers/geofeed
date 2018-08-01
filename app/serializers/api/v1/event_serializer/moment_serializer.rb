class Api::V1::EventSerializer::MomentSerializer < ActiveModel::Serializer
  attributes :id, :geojson_point

  def geojson_point
    object.geojson
  end
end

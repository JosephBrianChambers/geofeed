class Api::V1::MomentSerializer < ActiveModel::Serializer
  attributes :id, :geojson_point

  def geojson_point
    object.geojson
  end
end

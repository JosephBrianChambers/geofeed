class Api::V1::MomentSerializer < ActiveModel::Serializer
  attributes :id, :geojson_point, :title

  def geojson_point
    object.geojson
  end
end

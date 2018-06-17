class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes :end_time, :id, :geo_fence, :moments, :start_time

  def geo_fence
    RGeo::GeoJSON.encode(object.loc_fence_geo)
  end

  def moments
    object.moments.map { |m| RGeo::GeoJSON.encode(m.loc_geo) }
  end
end

class Api::V1::EventSerializer < ActiveModel::Serializer
  attributes :end_time, :id, :geo_fence, :moments, :start_time

  has_many :moments

  def geo_fence
    RGeo::GeoJSON.encode(object.loc_fence_geo)
  end
end

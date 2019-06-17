class Api::V1::MomentSerializer < ActiveModel::Serializer
  attributes :id, :caption, :geojson_point, :title, :provider_id

  belongs_to :author
  has_many :medias

  def geojson_point
    object.geojson
  end
end

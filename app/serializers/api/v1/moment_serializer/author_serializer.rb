class Api::V1::MomentSerializer::AuthorSerializer < ActiveModel::Serializer
  attributes :id, :avatar_url, :name, :handle, :provider_id
end

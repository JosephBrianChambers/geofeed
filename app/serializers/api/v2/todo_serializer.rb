class Api::V2::TodoSerializer < ActiveModel::Serializer
  attributes :implemented

  def implemented
    false
  end
end

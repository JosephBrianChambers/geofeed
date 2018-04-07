class QuoteSerializer < ActiveModel::Serializer
  attributes :id, :text, :author, :next_id, :previous_id
end

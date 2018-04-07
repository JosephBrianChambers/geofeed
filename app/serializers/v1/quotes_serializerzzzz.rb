class QuotesSerializer < ActiveModel::Serializer
  attributes :id, :text, :author, :next_id, :previous_id, :raise

  def raise
    raise "sdlkfjkldjflk"

  end


end

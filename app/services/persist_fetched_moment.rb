class PersistFetchedMoment
  attr_reader :event, :moment_attributes, :author_attributes, :medias_attributes

  def self.call(event, parser_adapter)
    new(event, parser_adapter).call
  end

  def initialize(event, parser_adapter)
    @event = event
    @moment_attributes = parser_adapter.moment_attributes
    @author_attributes = parser_adapter.author_attributes
    @medias_attributes = parser_adapter.medias_attributes
  end

  def call
    moment = find_or_initialize_moment
    moment.author = persist_author
    moment.medias = medias_attributes.map { |attrs| Media.new(attrs) }
    moment.save!
    EventMoment.create(event_id: event.id, moment_id: moment.id)
  rescue ActiveRecord::RecordInvalid => e
    return if !!(e.message =~ /#{Moment::PROVIDER_DUPLICATE_MESSAGE}/)

    raise e
  end

  private

  def persist_author
    Author.find_or_initialize_by(author_attributes.slice(:content_provider_id, :provider_id)) do |author|
      author.assign_attributes(author_attributes)
      author.save!
    end
  end

  def find_or_initialize_moment
    Moment.find_or_initialize_by(moment_attributes.slice(:content_provider_id, :provider_id)) do |moment|
      moment.assign_attributes(moment_attributes)
    end
  end
end

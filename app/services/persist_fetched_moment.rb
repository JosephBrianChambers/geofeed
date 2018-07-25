class PersistFetchedMoment
  attr_accessor :event, :moment, :parsed_author

  def self.call(event, moment)
    new(event, moment).persist_records
  end

  def initialize(event, moment)
    @event = event
    @moment = moment

    raise(ArgumentError, "author must be present") unless (@parsed_author = moment.author)
  end

  def persist_records
    moment.author = author
    moment.save!
    moment.events << event
  rescue ActiveRecord::RecordInvalid => e
    return if !!(e.message =~ /#{Moment::PROVIDER_DUPLICATE_MESSAGE}/)

    raise e
  end

  private

  def author
    attrs = parsed_author.attributes
    a = Author.find_or_initialize_by(attrs.slice(:content_provider_id, :provider_id)) { |a| a.assign_attributes(attrs) }
    a.save!
    a
  end
end

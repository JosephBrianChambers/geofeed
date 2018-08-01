class PersistFetchedMoment
  attr_accessor :event, :moment, :parsed_author

  def self.call(event, moment, author)
    new(event, moment, author).persist_records
  end

  def initialize(event, moment, parsed_author)
    @event = event
    @moment = moment
    @parsed_author = parsed_author
  end

  def persist_records
    moment.author = persist_author
    moment.save!
    moment.events << event
  rescue ActiveRecord::RecordInvalid => e
    return if !!(e.message =~ /#{Moment::PROVIDER_DUPLICATE_MESSAGE}/)

    raise e
  end

  private

  def persist_author
    attrs = parsed_author.attributes
    a = Author.find_or_initialize_by(attrs.slice(:content_provider_id, :provider_id)) { |a| a.assign_attributes(attrs) }
    a.save!
    a
  end
end

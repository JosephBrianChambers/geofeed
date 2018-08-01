require 'rails_helper'

RSpec.describe PersistFetchedMoment do
  fixtures :content_providers

  subject { PersistFetchedMoment.new(event, moment, author) }

  describe "#persist_records" do
    let(:event) { create(:event) }

    describe "when moment is valid" do
      let(:moment) { build(:moment) }
      let(:author) { moment.author }

      it "persists moment" do
        expect { subject.persist_records }.to change { Moment.count }.by(1)
      end

      it "persists author" do
        expect { subject.persist_records }.to change { Author.count }.by(1)
      end

      it "adds moment to events moment" do
        expect { subject.persist_records }.to change { event.moments.count }.by(1)
      end

      describe "when moment author already persisted" do
        let!(:persisted_author) { create(:author) }
        let(:moment) { build(:moment, author: author) }
        let(:author) do
          attrs = {
            provider_id: persisted_author.provider_id,
            content_provider_id: persisted_author.content_provider_id
          }

          build(:author, attrs)
        end

        it "persists moment" do
          expect { subject.persist_records }.to change { Moment.count }.by(1)
        end

        it "does not persist author" do
          expect { subject.persist_records }.to change { Author.count }.by(0)
        end

        it "adds moment to events moment" do
          expect { subject.persist_records }.to change { event.moments.count }.by(1)
        end
      end
    end

    describe "when moment is invalid" do
      describe "when moment already persisted for provider" do
        let!(:persisted_moment) { create(:moment) }
        let(:moment) do
          attrs = {
            provider_id: persisted_moment.provider_id,
            content_provider_id: persisted_moment.content_provider_id
          }

          build(:moment, attrs)
        end
        let(:author) { build(:author) }

        it "does not persist moment" do
          expect { subject.persist_records }.to change { Moment.count }.by(0)
        end
      end
    end
  end
end

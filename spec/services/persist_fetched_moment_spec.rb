require 'rails_helper'

RSpec.describe PersistFetchedMoment do
  fixtures :content_providers

  subject { PersistFetchedMoment.new(event, parser_adapter) }

  let(:parser_adapter) do
    stubs = {
      moment_attributes: moment_attributes,
      author_attributes: author_attributes,
      medias_attributes: medias_attributes,
    }

    double("parser_adapter", stubs)
  end

  describe "#call" do
    let(:event) { create(:event) }

    describe "when moment attributes are valid" do
      let(:moment_attributes) { build(:moment, author: nil).attributes }
      let(:author_attributes) { build(:author).attributes }
      let(:medias_attributes) { build_list(:media, 1).map(&:attributes) }

      it "persists moment" do
        expect { subject.call }.to change { Moment.count }.by(1)
      end

      it "persists author" do
        expect { subject.call }.to change { Author.count }.by(1)
      end

      it "adds moment to events moment" do
        expect { subject.call }.to change { event.moments.count }.by(1)
      end

      it "persists medias" do
        expect { subject.call }.to change { Media.count }.by(1)
      end

      describe "when moment author already persisted" do
        let!(:persisted_author) { create(:author) }
        let(:moment_attributes) { build(:moment, author: nil).attributes }
        let(:author_attributes) { persisted_author.attributes.except(:id) }
        let(:medias_attributes) { build_list(:media, 1).map(&:attributes) }

        it "persists moment" do
          expect { subject.call }.to change { Moment.count }.by(1)
        end

        it "does not persist author" do
          expect { subject.call }.to change { Author.count }.by(0)
        end

        it "adds moment to events moment" do
          expect { subject.call }.to change { event.moments.count }.by(1)
        end

        it "persists medias" do
          expect { subject.call }.to change { Media.count }.by(1)
        end
      end
    end

    describe "when moment is invalid" do
      describe "when moment already persisted for provider" do
        let!(:persisted_moment) { create(:moment) }
        let(:moment_attributes) { persisted_moment.attributes.except(:id) }
        let(:author_attributes) { persisted_moment.author.attributes.except(:id) }
        let(:medias_attributes) { persisted_moment.medias.map { |m| m.attributes.except(:id) } }

        it "does not persist moment" do
          expect { subject.call }.to change { Moment.count }.by(0)
        end

        it "does not persist new author" do
          expect { subject.call }.to change { Author.count }.by(0)
        end

        it "does not persist new medias" do
          expect { subject.call }.to change { Media.count }.by(0)
        end
      end
    end
  end
end

require 'rails_helper'

RSpec.describe Reviewable do
  subject { described_class.new(asset) }
  let(:asset) { GenericAsset.new }

  describe "#class" do
    it "should be the asset's class" do
      expect(subject.class).to eq asset.class
    end
  end
  describe "#public?" do
    context "when it has a public read group" do
      it "should be true" do
        subject.read_groups = ['public']

        expect(subject).to be_public
      end
      it "should index it" do
        subject.read_groups = ['public']

        expect(subject.to_solr["public_bsi"]).to eq true
      end
    end
    context "when it doesn't" do
      it "should be false" do
        expect(subject).not_to be_public
      end
      it "should index it" do
        expect(subject.to_solr["public_bsi"]).to eq false
      end
    end
  end

  describe "#public=" do
    context "when set to true" do
      it "should add public to read subject.oups" do
        subject.public = true

        expect(subject).to be_public
      end
    end
    context "when set to false" do
      it "should add public to read subject.oups" do
        subject.public = true
        subject.public = false

        expect(subject).not_to be_public
      end
    end
  end

  describe "#reviewed?" do
    context "when the workflow data says it's reviewed" do
      it "should be true" do
        subject.workflow_metadata.reviewed = true

        expect(subject).to be_reviewed
      end
      it "should index" do
        subject.workflow_metadata.reviewed = true

        expect(subject.to_solr["reviewed_bsi"]).to eq true
      end
    end
    context "when the workflow data doesn't say it's reviewed" do
      it "should be false" do
        expect(subject).not_to be_reviewed
      end
      it "should index" do
        expect(subject.to_solr["reviewed_bsi"]).to eq false
      end
    end
  end

  describe "#reviewed=" do
    context "when set to true" do
      it "should mark it was reviewed" do
        subject.reviewed = true

        expect(subject).to be_reviewed
      end
    end
    context "when set to false" do
      it "mark it as unreviewed" do
        subject.reviewed = true
        subject.reviewed = false

        expect(subject).not_to be_reviewed
      end
    end
  end
end

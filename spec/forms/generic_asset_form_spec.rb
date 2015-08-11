require 'rails_helper' 

RSpec.describe ImageForm do
  let(:generic_form){ described_class.new(image) }
  let(:image) {object_double(ValidatedAssetRepository.new(Image).new)}
  let(:property) { :lcsubject }
  let(:attribute_list) { {property.to_s=> []} }
  let(:validator) { instance_double(ControlledSubject) }
  let(:validators) { {property => [validator]} }

  before do
    allow(image).to receive(:attributes).and_return(attribute_list)
  end

  context "#property_hint" do
    before do
      allow(image).to receive(:validators).and_return(validators)
      allow(validator).to receive(:description).and_return("This is my message")
    end
    it "should return a string hint composed of validation messages" do
      expect(generic_form.property_hint(property)).to eq "This is my message"
    end
    context "when given multiple validators" do
      let(:validator_2) { instance_double(ControlledSubject, :description => "Message 2") }
      let(:validators) { {property => [validator, validator_2] } }
      it "should join both messages" do
        expect(generic_form.property_hint(property)).to eq "This is my message and Message 2"
      end
    end
  end

  describe ".terms" do
    it "should not include oembed" do
      expect(ImageForm.terms).not_to include :oembed
    end
  end

  describe "#template_terms" do
    context "when there is no template" do
      it "should fall back to class-level terms" do
        expect(generic_form.template_terms).to eq(GenericAssetForm.terms)
      end
    end

    context "when there is a template" do
      let(:template) { FactoryGirl.build(:form_template, :with_title, :with_desc) }
      before do
        template.properties << FactoryGirl.build(:form_template_property, :name => "foo")
        generic_form.template = template
      end

      it "should return the template's fields" do
        expect(generic_form.template_terms).to eq(["title", "description", "foo"])
      end

      it "shouldn't return hidden fields" do
        template.properties.last.visible = false
        expect(generic_form.template_terms).to eq(["title", "description"])
      end
    end
  end
end

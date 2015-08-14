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

  describe "#hidden_terms" do
    context "when there is no template" do
      it "should be empty" do
        expect(generic_form.hidden_terms).to be_empty
      end
    end
    context "when there is a template" do
      let(:template) { instance_double(FormTemplate) }
      before do
        generic_form.template = template
        allow(described_class).to receive(:terms).and_return([:foo, :banana])
        allow(template).to receive(:visible_property_names).and_return(["foo", "bar"])
      end

      it "should return the difference" do
        expect(generic_form.hidden_terms).to eq([:banana])
      end
    end
  end

  describe "#template_terms" do
    context "when there is no template" do
      it "should fall back to class-level terms" do
        expect(generic_form.template_terms).to eq(GenericAssetForm.terms)
      end
    end

    context "when there is a template" do
      let(:template) { instance_double(FormTemplate) }
      before do
        generic_form.template = template
        allow(template).to receive(:visible_property_names).and_return(["foo", "bar"])
      end

      it "should return template.visible_property_names" do
        expect(generic_form.template_terms).to eq(["foo", "bar"])
      end
    end
  end
  
  describe "#required_fields" do
    context "when there is no template" do
      it "should fall back to class-level required fields" do
        expect(generic_form.required_fields).to eq GenericAssetForm.required_fields
      end
    end
    context "when there is a template" do
      let(:template) { instance_double(FormTemplate) }
      before do
        generic_form.template = template
        allow(template).to receive(:required_property_names).and_return(["foo"])
      end
      it "should return the template's required properties" do
        expect(generic_form.required_fields).to eq [:foo]
        expect(generic_form.required?(:foo)).to eq true
      end
      it "should not lose the class' required fields" do
        allow(generic_form.class).to receive(:required_fields).and_return([:bar])
        expect(generic_form.required_fields).to eq [:bar, :foo]
      end
    end
  end
end

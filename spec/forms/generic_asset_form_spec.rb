require 'rails_helper' 

RSpec.describe ImageForm do
  let(:generic_form){ described_class.new(image) }
  let(:image) {object_double(ValidatedAssetRepository.new(Image).new)}
  let(:property) { :lcsubject }
  let(:attribute_list) { {property.to_s=> []} }
  let(:validator) { instance_double(SubjectCvValidator) }
  let(:validators) { {property => [validator]} }

  context "#property_hint" do
    before do
      allow(image).to receive(:validators).and_return(validators)
      allow(image).to receive(:attributes).and_return(attribute_list)
      allow(validator).to receive(:message).and_return("This is my message")
    end
    it "should return a string hint composed of validation messages" do
      expect(generic_form.property_hint(property)).to eq "This is my message"
    end
    context "when given multiple validators" do
      let(:validator_2) { instance_double(SubjectCvValidator, :message => "Message 2") }
      let(:validators) { {property => [validator, validator_2] } }
      it "should join both messages" do
        expect(generic_form.property_hint(property)).to eq "This is my message and Message 2"
      end
    end
  end
end

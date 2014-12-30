require 'rails_helper'

RSpec.describe OregonDigital::IdService do

  subject { OregonDigital::IdService.new }

  describe "#result" do

    let(:id) { subject.result }

    let(:pid1) { "99999" }
    let(:pid_exists) { false }

    before do
      stub(ActiveFedora::Base).exists?(anything) { pid_exists }
      stub(OregonDigital::IdGenerator).next_id { pid1 }
    end

    context "when the pid exists" do
      let(:pid_exists) { true }
      before do
        stub(OregonDigital::IdGenerator).next_id { pid1 }
        stub(described_class).mint
      end
      it "should repeatedly try for uniqueness" do
        id
        expect(described_class).to have_received(:mint)
      end
    end
    context "when retry => false is false" do
      let(:id) { described_class.new(:retry => false).result }
      context "when the pid exists" do
        let(:pid_exists) { true }
        it "should raise an error" do
          expect{id}.to raise_error "#{pid1} is taken"
        end
      end
    end
    context "when a pid is given" do
      let(:id) { described_class.new(:pid => "955").result }
      context "and it doesn't exist" do
        it "should return that pid" do
          expect(id).to eq "955"
        end
      end
      context "and it exists" do
        let(:pid_exists) { true }
        it "should raise an error" do
          expect{id}.to raise_error "955 is taken"
        end
      end
    end
  end

  describe "create" do
    subject { described_class }
    let(:fake_service) { fake(:id_service) }
    it "should call initialize without the retry option.result" do
      stub(subject).new(any_args) { fake_service }
      subject.create("monkeys")
      expect(subject).to have_received.new(:pid => "monkeys", :retry => false)
      expect(fake_service).to have_received(:result)
    end
  end
  
  describe "#mint" do
    let(:fake_service) { fake(:id_service) }
    it "should call new.result" do
      stub(described_class).new(any_args) { fake_service }
      described_class.mint
      expect(described_class).to have_received.new
      expect(fake_service).to have_received(:result)
    end
  end

end

RSpec.describe OregonDigital::IdGenerator do
  describe '.next_id' do
    let(:result) { described_class.next_id }
    it "should return valid ID" do
      expect(OregonDigital::IdService.valid?(result)).to eq true
    end
    it "should not mint the same id twice in a row" do
      expect(result).not_to eq described_class.next_id
    end
    it "should create many unique ids", :slow => true do
      a = []
      threads = (1..10).map do
        Thread.new do
          100.times do
            a <<  described_class.next_id
          end
        end
      end
      threads.each(&:join)
      expect(a.uniq.count).to eq a.count
    end
    xit "should create many unique ids when hit by multiple processes " do
      rd, wr = IO.pipe
      2.times do
        fork do
          rd.close
          threads = (1..10).map do
            Thread.new do
              20.times do
                wr.write described_class.next_id
                wr.write " "
              end
            end
          end
          threads.each(&:join)
          wr.close
        end
      end
      wr.close
      2.times do
        Process.wait
      end
      s = rd.read
      rd.close
      a = s.split(" ")
      expect(a.uniq.count).to eq a.count
    end
  end
end

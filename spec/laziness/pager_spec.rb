describe Slack::Pager do
  describe "#initialize" do
    let(:page) { { limit: 20 } }

    it "initializes with a page" do
      expect(described_class.new(page).page).to eq page
    end

    it "saves the limit" do
      expect(described_class.new(page).limit).to eq 20
    end

    it "initializes a nil cursor" do
      expect(described_class.new(page).cursor).to be_nil
    end
  end

  describe "#empty?" do
    context "with a non-empty page" do
      it "is not empty" do
        expect(described_class.new({ limit: 200 })).to_not be_empty
      end
    end

    context "with an empty page" do
      it "is empty" do
        expect(described_class.new({})).to be_empty
      end
    end

    context "with a nil page" do
      it "is empty" do
        expect(described_class.new(nil)).to be_empty
      end
    end
  end

  describe "#to_h" do
    subject { described_class.new({ limit: 200 }) }

    it "returns a hash with the limit and the cursor" do
      expect(subject.to_h).to eq({ limit: 200, cursor: nil })
    end
  end
end

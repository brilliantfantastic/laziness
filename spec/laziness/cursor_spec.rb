describe Slack::Cursor do
  describe '#initialize' do
    let(:page) { { limit: 10 } }

    it 'initializes with page attributes' do
      expect(described_class.new(page).page).to eq page
    end

    it 'does not require a block' do
      expect { described_class.new(page) }.to_not raise_error
    end

    it 'yields a pager' do
      expect { |b| described_class.new(page, &b) }.to yield_with_args(Slack::Pager)
    end

    context 'with a nil page' do
      it 'yields an empty pager' do
        described_class.new(nil) do |pager|
          expect(pager).to be_empty
        end
      end
    end
  end
end

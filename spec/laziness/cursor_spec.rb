describe Slack::Cursor do
  describe '#initialize' do
    let(:page) { { limit: 10 } }

    it 'initializes with page attributes' do
      expect(described_class.new(page).page).to eq page
    end
  end

  describe '#paginate' do
    let(:page) { { limit: 10 } }

    subject { described_class.new(page) }

    it 'does not require a block' do
      expect { subject.paginate }.to_not raise_error
    end

    it 'yields a pager' do
      expect { |b| subject.paginate(&b) }.to yield_with_args(Slack::Pager)
    end

    context 'with a nil page' do
      subject { described_class.new(nil) }

      it 'yields with an empty pager' do
        subject.paginate do |pager|
          expect(pager).to be_empty
        end
      end
    end
  end
end

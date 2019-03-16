describe Slack::Cursor do
  describe '#initialize' do
    let(:page) { { limit: 10 } }

    it 'initializes with page attributes' do
      expect(described_class.new(page).page).to eq page
    end
  end

  describe '#paginate' do
    let(:first_response) do
      {
        "ok" => true,
        "channels" => [{
          "id" => "C01"
        }],
        "response_metadata" => {
          "next_cursor" => "onto-second-request"
        }
      }
    end
    let(:last_response) do
      {
        "ok" => true,
        "channels" => [{
          "id" => "C03"
        }],
        "response_metadata" => {
          "next_cursor" => ""
        }
      }
    end
    let(:page) { { limit: 10 } }
    let(:second_response) do
      {
        "ok" => true,
        "channels" => [{
          "id" => "C02"
        }],
        "response_metadata" => {
          "next_cursor" => "onto-last-request"
        }
      }
    end

    subject { described_class.new(page) }

    it 'does not require a block' do
      expect { subject.paginate }.to_not raise_error
    end

    it 'yields a pager' do
      expect { |b| subject.paginate(&b) }.to yield_with_args(Slack::Pager)
    end

    it 'returns the results of each yield' do
      expected = [first_response, second_response, last_response]
      index = 0
      responses = subject.paginate do |pager|
        response = expected[index]
        index += 1
        response
      end

      expect(responses).to eq(expected)
    end

    it 'updates the cursor on the pager' do
      expect_any_instance_of(Slack::Pager).to \
        receive(:next).with("onto-last-request").and_call_original

      responses = [second_response, last_response]
      subject.paginate do |pager|
        responses.shift
      end
    end

    context 'with a too many requests error' do
      let(:page) { { limit: 10, max_retries: 2 } }
      let(:response) { OpenStruct.new(headers: { 'retry-after' => '0' }) }

      it 'tries again when there is a max retries setting' do
        number_of_tries = 0

        expect {
          subject.paginate do |pager|
            number_of_tries += 1
            raise Slack::TooManyRequestsError, response
          end
        }.to raise_error(Slack::TooManyRequestsError)

        expect(number_of_tries).to eq 3
      end

      context 'without a max retries' do
        it 'bubbles up the error' do
          expect do
            subject.paginate do |pager|
              raise Slack::TooManyRequestsError, response
            end
          end.to raise_error Slack::TooManyRequestsError
        end
      end
    end

    context 'with a sleep interval' do
      let(:page) { { limit: 10, sleep_interval: 2 } }

      it 'sleeps in between requests' do
        expect(subject).to receive(:sleep).with(2)

        responses = [second_response, last_response]
        subject.paginate do |pager|
          responses.shift
        end
      end
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

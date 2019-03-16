module SlackStubFactory
  def stub_slack_request(method, path, fixtures)
    fixtures = [fixtures].flatten

    full_path = "https://slack.com/api/#{path}"

    stub = stub_request(method, full_path)
    begin
      fixture = fixtures.shift
      stub.to_return(status: 200, body: slack_json_fixture(fixture))
    end while !fixtures.empty?

    stub
  end

  def slack_json_fixture(fixture)
    File.read(File.join('spec', 'support', 'fixtures', fixture)).strip.gsub(/\n\s*/, "")
  end
end

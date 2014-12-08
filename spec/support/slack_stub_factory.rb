module SlackStubFactory
  def stub_slack_request(method, path, fixture)
    full_path = "https://slack.com/api/#{path}"
    stub_request(method, full_path).to_return(status: 200, body: slack_json_fixture(fixture))
  end

  def slack_json_fixture(fixture)
    File.read(File.join('spec', 'support', 'fixtures', fixture)).strip.gsub(/\n\s*/, "")
  end
end

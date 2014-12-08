describe 'API errors' do
  let(:access_token) { "12345" }
  subject { Slack::Client.new access_token }

  # user_not_visible - The requested user is not visible to the calling user

  it 'raises an not authed error if a no authentication token was provided' do
    response = {
      ok: false,
      error: "not_authed"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::NotAuthedError
  end

  it 'raises an invalid auth error if an invalid authentication token was provided' do
    response = {
      ok: false,
      error: "invalid_auth"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::InvalidAuthError
  end

  it 'raises an account inactive error if the authentication token is for a deleted user' do
    response = {
      ok: false,
      error: "account_inactive"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::AccountInactiveError
  end

  it 'raises a user not found error if the user id was invalid' do
    response = {
      ok: false,
      error: "user_not_found"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::UserNotFoundError
  end

  it 'raises a user not visible error if the user does not have permission to see the requested user' do
    response = {
      ok: false,
      error: "user_not_visible"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::UserNotVisibleError
  end

  it 'raises an http error if the error is not known' do
    response = {
      ok: false,
      error: "blah"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::APIError
  end
end

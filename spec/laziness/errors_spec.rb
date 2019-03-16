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

  it 'raises a user is bot error if the user is a bot user' do
    response = {
      ok: false,
      error: "user_is_bot"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::UserIsBotError
  end

  it 'raises a user is restricted error if the user is not allowed to perform the action' do
    response = {
      ok: false,
      error: "user_is_restricted"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.users.all }.to raise_error Slack::UserIsRestrictedError
  end

  it 'raises a channel not found error if the channel id was invalid' do
    response = {
      ok: false,
      error: "channel_not_found"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::ChannelNotFoundError
  end

  it 'raises a channel already archived error if the channel id was already archived' do
    response = {
      ok: false,
      error: "already_archived"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::AlreadyArchivedError
  end

  it 'raises a channel not archived error if the channel id is not archived' do
    response = {
      ok: false,
      error: "not_archived"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::NotArchivedError
  end

  it 'raises a general channel archived error if the channel is the general channel' do
    response = {
      ok: false,
      error: "cant_archive_general"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::CantArchiveGeneralError
  end

  it 'raises a last restricted account error if the channel is restricted' do
    response = {
      ok: false,
      error: "last_ra_channel"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::LastRaChannelError
  end

  it 'raises a restricted action error if the user does not have the correct permissions' do
    response = {
      ok: false,
      error: "restricted_action"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::RestrictedActionError
  end

  it 'raises a name taken error if the channel name already exists' do
    response = {
      ok: false,
      error: "name_taken"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::NameTakenError
  end

  it 'raises a no channel error if the channel name was not provided' do
    response = {
      ok: false,
      error: "no_channel"
    }
    stub_request(:get, "https://slack.com/api/channels.list?exclude_archived=0&token=#{access_token}").
        to_return(status: 200, body: response.to_json)
    expect { subject.channels.all }.to raise_error Slack::NoChannelError
  end

  it 'raises a too many requests error if the status is 429' do
    response = {
      ok: false,
      error: "ratelimited"
    }
    stub_request(:get, "https://slack.com/api/users.list?token=#{access_token}").
        to_return(status: 429,
                  body: response.to_json,
                  headers: { "Retry-After" => "30" })
    expect { subject.users.all }.to \
      raise_error Slack::TooManyRequestsError, "Retry after 30 seconds"
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

laziness
========

## DESCRIPTION

A [Slack](http://slack.com) [API](http://api.slack.com) wrapper written in Ruby.

## INSTALLATION

Add this line to your Gemfile:

```
gem 'laziness'
```

And then execute:

```
bundle install
```

Or install it yourself:

```
gem install laziness
```

## WEB API USAGE

The [Slack Web API](https://api.slack.com/web) is made up of HTTP RPC-style methods that allow you to communicate with Slack as yourself via an access token.

You start by creating a `Client` with the access token you want to use. You can make calls to each [type](https://api.slack.com/types) using the [methods](https://api.slack.com/methods).

```
client = Slack.client(access_token: "your-access-token")
```

### Channels

```
client.channels.all # lists out all the channels
client.channels.find(channel_id) # get info about a specific channel
client.channels.archive(channel_id) # archives the specific channel
client.channels.unarchive(channel_id) # unarchives the specific channel

channel = client.channels.create("testing") # creates the new channel

client.channels.history(channel_id, latest: DateTime.now, oldest: 2.weeks.ago, count: 1000) # lists out the messages for the specific channels
client.channels.invite(channel_id, user_id) # invites the specific user to the specific channel
```

#### TODO:

- [ ] [channels.history](https://api.slack.com/methods/channels.history)
- [ ] [channels.invite](https://api.slack.com/methods/channels.invite)
- [ ] [channels.join](https://api.slack.com/methods/channels.join)
- [ ] [channels.kick](https://api.slack.com/methods/channels.kick)
- [ ] [channels.leave](https://api.slack.com/methods/channels.leave)
- [ ] [channels.mark](https://api.slack.com/methods/channels.mark)
- [ ] [channels.rename](https://api.slack.com/methods/channels.rename)
- [ ] [channels.setPurpose](https://api.slack.com/methods/channels.setPurpose)
- [ ] [channels.setTopic](https://api.slack.com/methods/channels.setTopic)

### Chat

```
message = client.chat.create("Hello world", channel_id) # creates a new message
message = client.chat.update("Hello again", channel_id, message.ts) # updates the message with the specified timestamp
client.chat.delete(channel_id, message.ts) # deletes the message with the specified timestamp
```

### Emoji

### Files

### Groups

```
client.groups.all # lists out all the groups
client.groups.find(group_id) # get info about a specific group
client.groups.archive(group_id) # archives the specific group
client.groups.close(group_id) # closes the specific group
client.groups.unarchive(group_id) # unarchives the specific group

group = client.groups.create("testing") # creates the new group
group = client.groups.copy(group_id) # archives the specified group and returns a copy
group = client.groups.invite(group_id, user_id) # invites the specified user to the specified group and returns the group
client.groups.kick(group_id, user_id) # removes the specified user from the specified group
client.groups.leave(group_id) # removes the current user from the specified group
client.groups.open(group_id) # opens the specified group
client.groups.update_purpose(group_id, purpose) # updates the purpose for the specific group
client.groups.update_topic(group_id, topic) # updates the topic for the specific group
```

#### TODO:

- [ ] [groups.history](https://api.slack.com/methods/groups.history)
- [ ] [groups.mark](https://api.slack.com/methods/groups.mark)
- [ ] [groups.rename](https://api.slack.com/methods/groups.rename)

### IM

```
client.im.all # lists all the direct message channels available for your account
client.im.open # opens a direct message channel with a specific user
client.im.close # closes a direct message channel
client.im.mark # specifies where the channel's messages were last read
```

#### TODO:

- [ ] [im.history](https://api.slack.com/methods/im.history)

### MPIM

### API

### Auth

```
client.auth.test # get info about a specific oauth token
```

### OAuth

```
client.oauth.access(client_id, client_secret, code, redirect_uri) # exchange api token for code
```

### Pins

### Reactions

### RTM

```
client.rtm.start # get an rtm session back with a url for connecting
```

### Search

### Stars

### Teams

### Users

```
client.users.all # lists out all the users
client.users.find(user_id) # get info about a specific user
client.users.set_active # sets the current user (defined by the access_token) as active
```

## REAL TIME API USAGE

The [Slack Real Time Messaging API](https://api.slack.com/rtm) is made up of Websocket events that allow you to communicate with Slack as a bot (or yourself) with an access token.

You start by creating a `Client` with the access token you want to use (bot or otherwise) and call the `rtm.start` method which will return the websocket url to use. You can make wait for [events](https://api.slack.com/events) and respond to those directly.

```
client = Slack::Client.new bot_access_token
session = client.rtm.start

# Create a websocket for the session
ws = Slack::RealTimeClient.new(session)

# Respond to open, close, and error events
ws.on(:error) { |event| print "ERROR OCCURRED (@ #{Time.now}): #{event.inspect}\n" }
ws.on(:close) { |event| print "CLOSED! (@ #{Time.now}): #{event.inspect}\n" }

# Respond to Slack events
ws.on(:message) do |data|
  print "RECEIVED MESSAGE (@ #{Time.now}): #{data.inspect}\n"
  # Message was placed in the Slack channel
end
ws.on(:channel_left) do |data|
  print "SOMEONE LEFT (@ #{Time.now}): #{data.inspect}\n"
end
#...

# Run the websocket as a client
ws.run
```

## CONTRIBUTING

1. Clone the repository `git clone https://github.com/brilliantfantastic/laziness`
1. Create a feature branch `git checkout -b my-awesome-feature`
1. Codez!
1. Commit your changes (small commits please)
1. Push your new branch `git push origin my-awesome-feature`
1. Create a pull request `hub pull-request -b brilliantfantastic:master -h brilliantfantastic:my-awesome-feature`

## RELEASING A NEW GEM

1. Bump the VERSION in `lib/laziness/version.rb`
1. run `bundle exec rake build`
1. Commit changes and push to GitHub
1. run `bundle exec rake release`

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

## USAGE

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
```

#### TODO:

- [ ] [groups.history](https://api.slack.com/methods/groups.history)
- [ ] [groups.invite](https://api.slack.com/methods/groups.invite)
- [ ] [groups.kick](https://api.slack.com/methods/groups.kick)
- [ ] [groups.leave](https://api.slack.com/methods/groups.leave)
- [ ] [groups.mark](https://api.slack.com/methods/groups.mark)
- [ ] [groups.open](https://api.slack.com/methods/groups.open)
- [ ] [groups.rename](https://api.slack.com/methods/groups.rename)
- [ ] [groups.setPurpose](https://api.slack.com/methods/groups.setPurpose)
- [ ] [groups.setTopic](https://api.slack.com/methods/groups.setTopic)

### IM

### Auth

```
client.auth.test # get info about a specific oauth token
```

### Presence

### Search

### Stars

### Users

```
client.users.all # lists out all the users
client.users.find(user_id) # get info about a specific user
client.users.set_active # sets the current user (defined by the access_token) as active
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
1. Commit changes and push to GitHub
1. run `bundle exec rake build`
1. run `bundle exec rake release`

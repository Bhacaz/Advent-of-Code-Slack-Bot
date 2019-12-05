# Advent of code Slack Bot

This is a Slack bot to post a Advent of code Private Leaderboard to a Slack channel
when someone complete a challenge.

<img width="419" alt="Screen Shot 2019-12-05 at 16 24 14" src="https://user-images.githubusercontent.com/7858787/70275316-ea725880-177b-11ea-88c3-f27eec8afd19.png">

### Prerequisites:
* `slack_url`: An [_Incoming WebHooks_](https://my.slack.com/services/new/incoming-webhook/) url for workplace Slack.
* `slack_channel`: The name of the channel you want to post the LeaderBoard
* `session`: A cookie session token from Advent of Code. It can be find in a request header in the devtool
of your browser.
* `leaderboard_id`: The ID of your private Leaderboard. It can be found at the end of the url of
 your Leaderboard`https://adventofcode.com/2019/leaderboard/private/view/<<XXXXX>>>`
 
 You can create a `config/application.yml` file to set those env variables
 
### Running:
* Run the Rails server `bin/rails server`
* Create a cron job that will fire the _Incoming WebHooks_ if someone recently
complete a challenge every 10 minutes.

```bash
$ EDITOR=nano crontab -e
```

* Add this line
```bash
*/10 * * * * curl http://localhost:3000/api/exec_webhook
```

### Build on: 
* Ruby 2.6.5
* Rails 6.0.1

# Advent of code Slack Bot

This is a Slack bot to post a Advent of code Private Leaderboard to a Slack channel
when someone complete a challenge.

<img width="457" alt="Screen Shot 2019-12-04 at 20 19 29" src="https://user-images.githubusercontent.com/7858787/70195482-d96e0c80-16d3-11ea-8b9c-a8000e63476f.png">

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

* Add that line
```bash
*/10 * * * * curl http://localhost:3000/api/exec_webhook
```

### Settings: 
* Ruby 2.6.5
* Rails 6.0.1

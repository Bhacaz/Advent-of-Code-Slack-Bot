
require 'httparty'
class SlackService

  SLACK_URL = "https://hooks.slack.com/services/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"

  def initialize(new_score_member_ids = [])
    @new_score_member_ids = new_score_member_ids
  end

  def send_webhook
    HTTParty.post(SLACK_URL, body: build_body, headers: { "Content-type" => 'application/json' })
  end

  def members_score_to_string
    scores = LeaderboardService.members_last_scores.map do |member|
      row = "#{member.score.to_s.ljust(20)}#{member.stars.to_s.ljust(20)}#{member.name}"
      row = "*#{row}*" if @new_score_member_ids.include? member.member_id
      row
    end
    header = "#{'*Score*'.ljust(21)}#{'*Stars* ⭐'.ljust(15)}<https://adventofcode.com/2019/leaderboard/private/view/704521|*Leaderboard*>️"
    [header, *scores].join("\n")
  end

  def build_body
    {
      "blocks": [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": members_score_to_string
        }
    },
      {
        "type": "context",
        "elements": [
          {
            "type": "mrkdwn",
            "text": "Last updated: #{Time.now.in_time_zone('Eastern Time (US & Canada)').strftime("%H:%M:%S")}"
          }
        ]
      }
    ]
    }.to_json
  end
end


require 'httparty'
class SlackService

  SLACK_URL = "https://hooks.slack.com/services/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"

  def initialize(new_score_member_ids = [])
    @new_score_member_ids = new_score_member_ids
  end

  def send_webhook
    HTTParty.post(SLACK_URL, body: build_body)
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
      channel: 'test-aoc',
      username: 'Advent of code',
      icon_url: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnfQ7zvIJfksV5SHqLnfIzkR6IB8mp77-G0Qiw5pTdLDrzexZW&s',
      text: members_score_to_string,
    }.to_json
  end
end

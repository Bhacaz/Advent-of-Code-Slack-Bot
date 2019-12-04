
require 'net/http'

class LeaderboardService
  attr_reader :send_webhook, :new_scores_member_ids

  LEADERBOARD_URL = "https://adventofcode.com/#{Date.current.year}/leaderboard/private/view/#{ENV['leadboard_id']}.json"

  def self.execute_task
    service = LeaderboardService.new
    members = service.get_source_leaderboard
    service.save_score(members)
    if service.send_webhook
      SlackService.new(service.new_scores_member_ids).send_webhook
    end
  end

  def initialize
    @send_webhook = false
    @new_scores_member_ids = []
  end

  def get_source_leaderboard
    headers = { cookie: "session=#{ENV['session']}" }

    response = HTTParty.get(LEADERBOARD_URL, headers: headers)
    body = JSON.parse(response.body)
    body['members'].map do |member_id, member|
      Member.new(
        member_id: member_id,
        name: member['name'],
        stars: member['stars'],
        score: member['local_score']
      )
    end
  end

  def save_score(members)
    members.each do |member|
      if Member.select(:score).where(member_id: member.member_id).last&.score != member.score
        member.save!
        @send_webhook = true
        @new_scores_member_ids << members.member_id
      end
    end
  end

  def self.members_last_scores
    member_ids = Member.group(:member_id).maximum(:id).values
    Member.where(id: member_ids).order(score: :desc)
  end
end

class ApplicationController < ActionController::API

  def home
    render body: 'Hello', content_type: 'text/plain'
  end

  def exec_webhook
    LeaderboardService.execute_task
  end
end

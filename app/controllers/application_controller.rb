class ApplicationController < ActionController::Base
  before_action :github

  def index
  end

  def github
    @github_name = GithubFacade.github_info.name
    @github_logins = GithubFacade.github_info("/collaborators", true)
    @github_pulls = GithubFacade.github_info("/pulls?state=closed&per_page=100").count
  end
end

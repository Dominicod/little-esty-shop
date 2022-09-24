class ApplicationController < ActionController::Base
  before_action :github

  @@github_api =
    {
      github_name: GithubFacade.github_info.name,
      github_logins: GithubFacade.github_info("/collaborators", true),
      github_pulls: GithubFacade.github_info("/pulls?state=closed&per_page=100").count
    }

  def welcome
  end

  def github
    @github_name = @@github_api[:github_name]
    @github_logins = @@github_api[:github_logins]
    @github_pulls = @@github_api[:github_pulls]
  end
end

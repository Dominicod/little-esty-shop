class GithubFacade
  def self.github_info(path = "", auth_required = false)
    json_response = GithubService.request(path, auth_required)
    if path == ""
      GithubName.new(json_response)
    elsif path == "/collaborators"
      json_response.map do | collaborator |
        GithubCollaborator.new(collaborator)
      end
    elsif path == "/pulls?state=closed&per_page=100"
      json_response.map do | id |
        GithubPulls.new(id)
      end
    end
  end
end

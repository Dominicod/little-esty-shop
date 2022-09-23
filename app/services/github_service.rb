require 'httparty'
require 'json'

class GithubService
  def self.request(path, auth_required)
    if path == '/collaborators'
      response = HTTParty.get("https://api.github.com/repos/Dominicod/little-esty-shop#{path}", headers: {authorization: "Bearer " + ENV['token']})
      GithubService.parse(response)
    elsif path == '/pulls?state=closed&per_page=100'
      response = HTTParty.get("https://api.github.com/repos/Dominicod/little-esty-shop#{path}", headers: {authorization: "Bearer " + ENV['token']})
      GithubService.parse(response)
    else
      response = HTTParty.get("https://api.github.com/repos/Dominicod/little-esty-shop#{path}", headers: {authorization: "Bearer " + ENV['token']})
      GithubService.parse(response)
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

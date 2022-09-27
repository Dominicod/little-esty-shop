require 'httparty'
require 'json'

class DateService
  def self.request
    response = HTTParty.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    DateService.parse(response)
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end

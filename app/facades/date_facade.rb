class DateFacade
  def self.next_three_holidays
    json_response = DateService.request
    object_map = json_response.map {|entry| DateHoliday.new(entry) }
    object_map.shift(3)
  end
end

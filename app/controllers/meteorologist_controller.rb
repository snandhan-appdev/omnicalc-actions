require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather
    @street_address = params.fetch("user_street_address")
    sanitized_street_address = URI.encode(@street_address)

    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the string @street_address.
    # A sanitized version of the street address, with spaces and other illegal
    #   characters removed, is in the string sanitized_street_address.
    # ==========================================================================

    url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + sanitized_street_address + "&key=AIzaSyBr-0XDfztIIUGyPRfa1D5KfPvURvAk2e4"
    
    parsed_data = JSON.parse(open(url).read)

    @lat_now = parsed_data.dig("results", 0, "geometry", "location", "lat").to_s

    @lng_now = parsed_data.dig("results", 0, "geometry", "location", "lng").to_s
    
    new_url = "https://api.darksky.net/forecast/f9cb6cc9b60c5cd7de1604db6461f3f9/" + @lat_now + "," + @lng_now
    new_data = JSON.parse(open(new_url).read)

    @current_temperature = new_data.dig("currently","temperature")

    @current_summary = new_data.dig("currently","summary")

    @summary_of_next_sixty_minutes = new_data.dig("minutely","summary")

    @summary_of_next_several_hours = new_data.dig("hourly","summary")

    @summary_of_next_several_days = new_data.dig("daily","summary")

    render("meteorologist_templates/street_to_weather.html.erb")
  end

  def street_to_weather_form
    render("meteorologist_templates/street_to_weather_form.html.erb")
  end
end

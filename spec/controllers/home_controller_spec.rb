require 'open-uri'
require 'json'
require 'rails_helper'

Rspec.describe HomeController, type: controller do
  config.infer_spec_type_from_file_location!

# test successful home page response
  it "successfully responds" do
    get :index
    expect(response.status).to eq(200)

    end


# test nytimes article api call
  it "successfully receives information from nytimes article api call" do
    r_richards = User.new(
    username: 'RRichards',
    password: 'stretch',
    interest1: 'cloud computing',
    free_time: 'dancing',
    zipcode: '10007', 
    city: 'new york',
    state: 'new york')

    interest1 = interest1.gsub(' ', '+')
    @nytimes_data = data_retrieve("http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + interest1 + "&sort=newest&api-key=bd2d3da37f58e2247ab30155400fc222:3:67128716")
    # @nytimes_data.empty? ? @nytimes_data = "No news on your interests at this time" : @nytimes_data
    @headline = @vnytimes_data["response"]["docs"]["headline"]["main"]

    expect(@nytimes_data).not_to eql(nil)
  end

# test nytimes article api var is storing data and not nil
it "successfully receives information from nytimes article api call" do
    r_richards = User.new(
    username: 'RRichards',
    password: 'stretch',
    interest1: 'cloud computing',
    free_time: 'dancing',
    zipcode: '10007', 
    city: 'new york',
    state: 'new york')

    interest1 = interest1.gsub(' ', '+')
    @nytimes_data = data_retrieve("http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + interest1 + "&sort=newest&api-key=bd2d3da37f58e2247ab30155400fc222:3:67128716")
    # @nytimes_data.empty? ? @nytimes_data = "No news on your interests at this time" : @nytimes_data
    @headline = @vnytimes_data["response"]["docs"]["headline"]["main"]

    expect(@headline).not_to eql(nil)
  end




# test weather underground api call
it "successfully receives information from weather underground api call" do
    r_richards = User.new(
    username: 'RRichards',
    password: 'stretch',
    interest1: 'cloud computing',
    free_time: 'dancing',
    zipcode: '10007', 
    city: 'new york',
    state: 'new york')

    @weather_rpt = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/conditions/q/" + r_richards.state + "/" + r_richards.city + ".json")
    @weather_forecast = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/forecast/q/" + r_richards.state + "/" + r_richards.city + ".json")

    @weather_current = @weather_rpt['current_observation']["temperature_string"]
    @weather_wind = @weather_rpt['current_observation']["wind_string"]
    @weather_humidity = @weather_rpt['current_observation']["relative_humidity"]
    @weather_feels = @weather_rpt['current_observation']["feelslike_string"]

    @weather_ftext = @weather_forecast["forecast"]["txt_forecast"]["forecastday"]["fcttext"]
    @weather_day = @weather_forecast["forecast"]["txt_forecast"]["forecastday"]["title"]

    expect(@weather_rpt).not_to eql(nil)
  end
# test pulling an array from an api call


# method to retrieve JSON data from the web
 def data_retrieve(url_string)
    url = url_string
    data_read =open(url).read
    data_result = JSON.parse(data_read)
    return
  end

  end # end of initial describe statement
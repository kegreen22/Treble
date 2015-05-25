class HomeController < ApplicationController

  require 'open-uri'
  require 'json'

  def index

    if logged_in?
  # get user interest from the database
  @user = current_user
  @interest_pre = @user.interest1
  puts @user.to_s
  puts @user.interest1
  @interest_pre = @interest_pre.gsub(/\s+/,'+') # add + symbol between each word if there are 2+ words to allow use in http searches - designates "or" in the article searches
  puts @interest_pre
  @zipcode = @user.zipcode
  puts current_user.zipcode

  @free_pre = @user.free_time  
  @free_pre = @free_pre.gsub(/\s+/,'+') # add + symbol between each word if there are 2+ words to allow use in http searches - designates "or" in the event searches
  puts @free_time

  @state_pre = "NY" 
  @city_pre = @user.city.gsub(/\s+/,'_')
  puts @city_pre
  # call api methods and insert interest into api call

  @testing = Date.today
  @limit = @testing.days_ago(14)
  @begin_time = @limit.to_s
  @begin_time = @begin_time.gsub('-','')
  puts @begin_time

  @nytimes_data = data_retrieve("http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + @interest_pre + "&begin_date=" + @begin_time + "&sort=newest&api-key=bd2d3da37f58e2247ab30155400fc222:3:67128716")
  @weather_rpt = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/conditions/q/" + @state_pre + "/" + @city_pre + ".json")
  @weather_forecast = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/forecast/q/" + @state_pre + "/" + @city_pre + ".json")
  @meetup_data = data_retrieve("https://api.meetup.com/2/open_events?&sign=true&photo-host=public&zip=" + current_user.zipcode + "&text=" + @interest_pre + "&page=20&key=6874237675483c4f5e12f416939655a")
  @nytimes_top = data_retrieve("http://api.nytimes.com/svc/topstories/v1/home.json?api-key=799bb4a946ced430d7d8611ca957387b:8:67128716")
  @nytimes_events = data_retrieve("http://api.nytimes.com/svc/events/v2/listings.json?&query=" + @free_pre + "&limit=20&api-key=3484b827fcc7f7a5962abbf4b36fdfc4:19:67128716")

  if @nytimes_data.blank?
   puts "art search bad" 
 end
  if @weather_rpt.blank? 
    puts "wthr rpt bad" 
  end
  if @weather_forecast.blank? 
    puts "forecast bad" 
  end
  if @meetup_data.blank? 
    puts "meetup bad" 
  end
  if @nytimes_top.blank? 
    puts "top bad" 
  end
  if @nytimes_events.blank? 
    puts "events bad" 
  end
 
  @hits = (@nytimes_data["response"]["meta"]["hits"]).to_i
  puts @hits
  
  @event_amt = (@nytimes_events["num_results"]).to_i
  puts @event_amt
  # check if any results are empty or nil and if so assign a default string
  
  
  @weather_current = @weather_rpt['current_observation']['temp_f']
  if @weather_current.blank?
    @weather_current = "No weather forecast information at this time"
    @weather_wind, @weather_humidity, @weather_feels, @weather_ftext, @weather_day = "No information at this time"
  else
  @weather_wind = @weather_rpt['current_observation']["wind_string"]
  @weather_humidity = @weather_rpt['current_observation']["relative_humidity"]
  @weather_feels = @weather_rpt['current_observation']["feelslike_string"]

  @weather_ftext = @weather_forecast["forecast"]["txt_forecast"]["forecastday"]  #["fcttext"]
  @weather_day = @weather_forecast["forecast"]["txt_forecast"]["forecastday"] #["title"]
  # @weather_fnextdaytext = []
end

  @test = 0 # use this to show other tabs; if it is = 1 then other tabs will be shown

  top_stories
  articles
  networking
  events

else
  render 'index'

end



end

  # assign json array info to variables
  
  
  def top_stories   # Top stories
   # check for useful results 
  if ((@nytimes_top["status"] != "OK") || (@nytimes_top["num_results"].to_i == 0))
  @top_flag == 0
  else
  @top_flag = 1
    @top_stories = @nytimes_top["results"] # with title being the link_to to the 'url'; 
    
   # @top_url = @nytimes_top["results"]["url"]
   # @top_date = @nytimes_top["results"]["last_updated"]
  end
end


  def articles    # Article search
   # check for useful results 
  if ((@nytimes_data["status"] != "OK") || (@nytimes_data["response"]["meta"]["hits"].to_i == 0)) 
  @article_flag = 0
  else
  @article_flag = 1
end


    #@headline = @nytimes_data["response"]["docs"] #["headline"]["main"]
    #if @headline.blank? 
    # @headline = "No news on your interests at this time" # test if there is data
    # @art_date, @art_url = "No information at this time"
  #else
   # @art_date = @nytimes_data["response"]["docs"] #["pub_date"]
   # @art_url = @nytimes_data["response"]["docs"] #["web_url"]
  #end
end

  def networking
#    @meetup_grpname = @meetup_data["results"]["group"]["name"]
 #   if @meetup_grpname.blank?
  #    @meetup_grpname = "No information on meetup groups" 
   #   @meetup_locname, @meetup_address, @meetup_city, @meetup_desc, @meetup_url, @meetup_status = "No information at this time"
    #else
    #@meetup_locname = @meetup_data["results"]["venue"]["name"]
    #@meetup_address = @meetup_data["results"]["venue"]["address1"]
    #@meetup_city = @meetup_data["results"]["venue"]["city"]
    #@meetup_desc = @meetup_data["results"]["name"]
    #@meetup_url = @meetup_data["results"]["event_url"]
    #@meetup_status = @meetup_data["results"]["status"]

#  end
end

  def events   # Events
 #   @events_desc = @nytimes_events["results"] #["web_description"]  # description of event
  #  if @events_desc.blank?
   #   @events_desc = "No information on local events meeting your free time interest"
    #  @events_name, @events_url, @events_free = "No information at this time"
    #else
    #@events_name = @nytimes_events["results"]["event_name"]
    # @events_date = @nytimes_events["results"][""]
   # @events_url = @nytimes_events["results"]["event_detail_url"]
   # @events_free = @nytimes_events["results"]["free"]
 # end
end

  def data_retrieve(url_string)
    url = url_string
    data_read =open(url).read
    @data_result = JSON.parse(data_read)

    return @data_result
  end



 

  # end of class
  
  end

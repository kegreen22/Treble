class HomeController < ApplicationController

  require 'open-uri'
  require 'json'

  def index

    if logged_in?
  # get user interest from the database
  @user = current_user
  @interest_pre = @user.interest1
  puts @user.slug
  puts @user.interest1
  @interest_pre = @interest_pre.gsub(/\s+/,'+') # add + symbol between each word if there are 2+ words to allow use in http searches - designates "or" in the article searches
  puts @interest_pre
  @zipcode = @user.zipcode
  puts current_user.zipcode

  @free_pre = @user.free_time  
  @free_pre = @free_pre.gsub(/\s+/,'+') # add + symbol between each word if there are 2+ words to allow use in http searches - designates "or" in the event searches
  # puts @free_pre 

  @state_pre = "NY" 
  @city_pre = @user.city.gsub(/\s+/,'_')
  # puts @city_pre
  # call api methods and insert interest into api call

  @testing = Date.today
  @limit = @testing.days_ago(14)
  @begin_time = @limit.to_s
  @begin_time = @begin_time.gsub('-','')
  puts @begin_time

  @nytimes_data = data_retrieve("http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + @interest_pre + "&begin_date=" + @begin_time + "&sort=newest&api-key=bd2d3da37f58e2247ab30155400fc222:3:67128716")
  @weather_rpt = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/conditions/q/" + @state_pre + "/" + @city_pre + ".json")
  # @weather_forecast = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/forecast/q/" + @state_pre + "/" + @city_pre + ".json")
  @meetup_data = data_retrieve("https://api.meetup.com/2/open_events?&sign=true&photo-host=public&zip=" + current_user.zipcode + "&text=" + @interest_pre + "&page=20&key=6874237675483c4f5e12f416939655a")
  @nytimes_top = data_retrieve("http://api.nytimes.com/svc/topstories/v1/home.json?api-key=799bb4a946ced430d7d8611ca957387b:8:67128716")
  @nytimes_events = data_retrieve("http://api.nytimes.com/svc/events/v2/listings.json?&query=" + @free_pre + "&limit=20&api-key=3484b827fcc7f7a5962abbf4b36fdfc4:19:67128716")

   
  # determine how many results were returned
  @hits = (@nytimes_data["response"]["meta"]["hits"]).to_i # article search hits
    
  @event_amt = @nytimes_events["results"].length # events hits
  
  @meetup_amt = @meetup_data["results"].length # meetup hits
  
  @top_stories1 = (@nytimes_top["results"]).length # top stories hits
  

  # see the current temperature
  #@weather_current = @weather_rpt['current_observation']['temp_f']
  

else
  render 'index'

end



end

  # assign json array info to variables
  
  
  def data_retrieve(url_string)
    url = url_string  # open url 
    data_read =open(url).read   # read the url
    @data_result = JSON.parse(data_read)  # parse JSON received from the api

    return @data_result #return parsed JSON data to an instance variable
  end



 

  # end of class
  
  end

class HomeController < ApplicationController

  require 'open-uri'
  require 'json'

  def index

    if logged_in?
  # get user interest from the database
  @user = current_user
  @interest_pre = @user.interest1
 
  @interest_pre = @interest_pre.gsub(/\s+/,'+') # add + symbol between each word if there are 2+ words to allow use in http searches - designates "or" in the article searches
 
  @zipcode = @user.zipcode
  
  @free_pre = @user.free_time  
  @free_pre = @free_pre.gsub(/\s+/,'+') # add + symbol between each word if there are 2+ words to allow use in http searches - designates "or" in the event searches
  

  @state_pre = @user.state.gsub(/\s+/,'_')
  @city_pre = @user.city.gsub(/\s+/,'_')
  

  @testing = Date.today
  @limit = @testing.days_ago(7)
  @begin_time = @limit.to_s
  @begin_time = @begin_time.gsub('-','')
 

  @nytimes_data = data_retrieve("http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + @interest_pre + "&begin_date=" + @begin_time + "&sort=newest&api-key=bd2d3da37f58e2247ab30155400fc222:3:67128716")
  @weather_rpt = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/conditions/q/" + @state_pre + "/" + @city_pre + ".json")
  # @weather_forecast = data_retrieve("http://api.wunderground.com/api/cfffe9ffeb7b662e/forecast/q/" + @state_pre + "/" + @city_pre + ".json")
  @meetup_data = data_retrieve("https://api.meetup.com/2/open_events?&sign=true&photo-host=public&zip=" + current_user.zipcode + "&text=" + @interest_pre + "&page=20&key=6874237675483c4f5e12f416939655a")
  @nytimes_top = data_retrieve("http://api.nytimes.com/svc/topstories/v1/home.json?api-key=799bb4a946ced430d7d8611ca957387b:8:67128716")
  @nytimes_events = data_retrieve("http://api.nytimes.com/svc/events/v2/listings.json?&query=" + @free_pre + "&limit=20&api-key=3484b827fcc7f7a5962abbf4b36fdfc4:19:67128716")

   
  # determine how many results were returned and rescue if there is an error
  if !@nytimes_data
    @nytimes_data = {}
    else
    @nytimes_data
  end
 
  if @weather_rpt
   @weather_rpt
   else
   @weather_rpt = {}
   puts @weather_rpt
 end
 
  if !@meetup_data 
  @meetup_data = {}
  else
  @meetup_data
  end

  if !@nytimes_top
   @nytimes_top = {} 
   else
    @nytimes_top
  end

  if !@nytimes_events 
   @nytimes_events = {}
   else
    @nytimes_events
  end

  

else
  render 'index'

end



end

  # assign json array info to variables
  def data_retrieve(url_string)
    url = url_string  # open url 
    
    begin
      data_read =open(url).read   # read the url
    rescue SocketError => e 
      return {}
    end

    @data_result = JSON.parse(data_read)  # parse JSON received from the api

    return @data_result #return parsed JSON data to an instance variable
      
  end



 

  # end of class
  
  end

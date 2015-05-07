class HomeController < ApplicationController

  require 'open-uri'
  require 'json'

  def home

  # get user interest from the database
  @interest1 = User.interest1
  @interest2 = User.interest2
  @zipcode = User.zipcode
  # call api methods and insert interest into api call
  @weather_final = weather_rpt
  @nytimes_final = nytimes
  @meetup_final = meetup
 
# view displays the api results

   end


  private

  def nytimes
    # insert api into nytimes api call
    url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + @interest1 "+" + @interest2 + "&sort=newest&api-key=bd2d3da37f58e2247ab30155400fc222:3:67128716"
    nyt_data = open(url).read
    # now parse and put into an array (shown below)
    nyt_result = JSON.parse(nyt_data)
  
  end


  def meetup
    # insert api into meetup api call
    url = "https://api.meetup.com/2/open_events.zip=" + self.zipcode + "&text=" + @interest1 + "+" + @interest2 + "&time=,1m&key=6874237675483c4f5e12f416939655a"
    meetup_data = open(url).read
    # now parse and put into an array (shown below)
    meetup_result = JSON.parse(meetup_data)

  end


  def indeed
    # insert api into meetup api call
    # url = "http://api.indeed.com/ads/apisearch?publisher=3117837613642246&q=" + @interest1 + "+" @interest2 + "&l=" + @zipcode + 
    #{ }"&sort=&radius=5&st=&jt=&start=&limit=50&fromage=15&filter=&latlong=0&co=us&chnl=&userip=" + machine ip + "&useragent=" + browser + "&v=2"

    # indeed_data = open(url).read
    # now parse and put into an array (shown below)
    # groups_result = XML.parse(groups_data) # check what is the correct method to parse to XML
  end

  def weather_rpt
    @user_state = User.state
    @user_city = User.city
    url = "http://api.wunderground.com/api/cfffe9ffeb7b662e/conditions/q/" + User.state + "/" + User.city + ".json"
    weather_data = open(url).read
    weather_result = JSON.parse(weather_data)
  end


  # end of class
  
  end

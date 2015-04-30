class HomeController < ApplicationController

  require 'open-uri'
  require 'json'

  def home

  # get user interest from the database
  @interest1 = User.interest1
  @interest2 = User.interest2
  @zipcode = User.zipcode
  # call api methods and insert interest into api call

  nytimes
  meetup
  indeed

# view displays the api results



  # use get request to retrieve JSON api information from NYT, Meetup & Indeed
  get_groups = 'http://api.meetup.com...'
  groups_params = user.interest  #this should be extracted to be a global variable
  url = "#{get_groups}   #whatever other parameters to include in , url (also make sure to limit the number of records returned)"
  # now get the contents of the url
  groups_data = open(url).read
  # now parse and put into an array (shown below)
  groups_result = JSON.parse(groups_data)


  get_news



  get_jobs

  end


  private

  def nytimes
  # insert api into nytimes api call


  url = "http://api.nytimes.com/svc/search/v2/articlesearch.json?&q=" + @interest1 "+" + @interest2 + "&sort=newest&api-key=bd2d3da37f58e2247ab30155400fc222:3:67128716"
  nyt_data = open(url).read
  # now parse and put into an array (shown below)
  nyt_result = JSON.parse(groups_data)
  
  end


  def meetup
  # insert api into meetup api call
  url = "https://api.meetup.com/2/open_events.zip=" + self.zipcode + "topic=" + @interest1 + "&time=,1w&key="
  meetup_data = open(url).read
  # now parse and put into an array (shown below)
  meetup_result = JSON.parse(groups_data)

  end


  def indeed
  # insert api into meetup api call
  url = "http://api.indeed.com/ads/apisearch?publisher=3117837613642246&q=" + @interest1 + "+" @interest2 + "&l=" + @zipcode + 
  "&sort=&radius=5&st=&jt=&start=&limit=50&fromage=15&filter=&latlong=0&co=us&chnl=&userip=" + machine ip + "&useragent=" + browser + "&v=2"

  indeed_data = open(url).read
  # now parse and put into an array (shown below)
  groups_result = XML.parse(groups_data) # check what is the correct method to parse to XML
  end

  # end of class
  
  end

class HomeController < ApplicationController

  require 'open-uri'
  require 'json'

  get_groups = 'http://api.meetup.com...'
  groups_params = user.interest  #this should be extracted to be a global variable
  url = "#{get_groups}#whatever other parameters to include in the url (also make sure to limit the number of records returned)"
  # now get the contents of the url
  groups_data = open(url).read
  # now parse and put into an array (shown below)
  groups_result = JSON.parse(groups_data)


  get_news



  get_jobs


end

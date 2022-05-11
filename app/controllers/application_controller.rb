class ApplicationController < Sinatra::Base
  set :default_content_type, 'application/json'
  
  # Add your routes here
  get "/" do
    { message: "Good luck with your project!" }.to_json
  end

  get "/signup" do
    { message: 'This is the signup page'}.to_json
  end

  get "/login" do
    {m: 'test'}.to_json
  end

  get "/weapons" do
    # this scrapes FFT Wiki for the weapons list
    url = 'https://finalfantasy.fandom.com/wiki/Final_Fantasy_Tactics_weapons'
    html = Nokogiri::HTML(URI.open(url))
    weapons_list = [] 
    html.search('table').each do |table|
      table.search('tr').search('th > a > span').each do |element|
        weapons_list << element.children[0].content
      end
    end
    # p html.search('table')[0]
    {weapson: weapons_list}.to_json
  end

end

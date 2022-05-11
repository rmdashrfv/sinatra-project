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
    url = 'https://gamefaqs.gamespot.com/psp/937312-final-fantasy-tactics-the-war-of-the-lions/faqs/76070/weapons'
    weapons_list = []
    html = Nokogiri::HTML5(URI.open(url))
    html.search('table').each {|t| p t.class}
    {weapson: weapons_list}.to_json
  end

end

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
    url = 'https://finalfantasy.fandom.com/wiki/Final_Fantasy_Tactics_weapons'
    html = Nokogiri::HTML(URI.open(url))
    weapons_list = [] 
    # full-width FFT article-table
    html.css('table[class="full-width FFT article-table"]').each do |table|
      # name = nil
      # desc = nil
      # atk  = nil
      weapon = {}
      table.search('tr').search('td').each_with_index { |el, i|
        p el.content
        case i
        when 0
          weapon[:atk] = el.content
        when 1
          weapon[:mag] = el.content
        when 2
          weapon[:def] = el.content
        else
          weapon[:desc] = el.content
        end
      }
      table.search('tr').search('th > a > span').each do |element|
        # weapon[:name] = element.content[0].content
        # weapons_list << element.children[0].content
      end
      weapons_list << weapon
    end
    {weapson: weapons_list}.to_json
  end

end

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

  get "/units" do
    base_url = 'http://www.ffmages.com/final-fantasy-tactics/job-classes/'
    unit_classes = %w[Archer Bard Calculator Chemist Dancer Geomancer Knight Lancer Mediator Mime Monk Oracle Priest Samurai Squire Summoner Thief Time\ Mage Ninja Wizard]
    unit_classes.each do |unit|
      full_url = %(#{base_url}#{unit.downcase.tr(' ', '-')})
    p full_url
    end
  end

  get "/weapons" do
    url = 'http://www.ffmages.com/final-fantasy-tactics/weapons/'
    weapons_list = []
    html = Nokogiri::HTML5(URI.open(url))
    weapon_categories = [] # Create a container for the categories, because they're not in tables
    html.search('h2').each do |h2|
      weapon_categories << h2.content # store the h2 textContent as str in the container
    end

    # loop over every table element
    html.search('table').each_with_index { |table, table_index|
      category = weapon_categories[table_index]
      table.css('tbody > tr').each_with_index { |tr, tr_index|
        next if tr_index == 0 # because this is the blank column
        weapon = {img: nil, name: nil, atk: nil, evade: nil, location: nil, cost: nil, attributes: nil, category: category}
        tr.css('td').each_with_index { |td, td_index|
          next if td_index == 0
          weapon[weapon.keys[td_index]] = td.content
        }
        weapons_list << weapon
      }
    }
    {weapons: weapons_list}.to_json
  end

end

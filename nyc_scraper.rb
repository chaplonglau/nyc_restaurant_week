require 'HTTParty'
require 'Nokogiri'
require 'JSON'
require 'pry-byebug'
require 'csv'
require 'yelp'
require 'axlsx'
require 'json'

# search_results > div.content-section-list.infinite-results-list > div:nth-child(1) > div > div.rest-row-info > div.rest-row-header > a > span
# search_results > div.content-section-list.infinite-results-list > div:nth-child(2) > div > div.rest-row-info > div.rest-row-header > a > span
# finding the restaurant name and pushing it and adding it to our array

def getRestaurants()
  restaurants=[]
  base_url="https://www.opentable.com/promo.aspx?covers=2&currentview=list&datetime=2018-01-22+19%3A00&metroid=8&promoid=69&ref=412&size=100&sort=Name"
  # page is the site's HTML in a massive string
  parseRestaurants(base_url,restaurants)

  #https://www.opentable.com/promo.aspx?covers=2&currentview=list&datetime=2018-01-22+19%3A00&metroid=8&promoid=69&ref=412&size=100&sort=Name
  #https://www.opentable.com/promo.aspx?covers=2&currentview=list&datetime=2018-01-22+19%3A00&metroid=8&promoid=69&ref=412&size=100&sort=Name&from=100
  #https://www.opentable.com/promo.aspx?covers=2&currentview=list&datetime=2018-01-22+19%3A00&metroid=8&promoid=69&ref=412&size=100&sort=Name&from=200
  #https://www.opentable.com/promo.aspx?covers=2&currentview=list&datetime=2018-01-22+19%3A00&metroid=8&promoid=69&ref=412&size=100&sort=Name&from=300
  # repeat for the next three pages 
  for i in 1..3
    new_url=base_url+"&from="+i.to_s+"00"
    parseRestaurants(new_url,restaurants)
  end
  p restaurants
end

def parseRestaurants(url,restaurants)
   # page is the site's HTML in a massive string
  page=HTTParty.get(url)
  # parse_page is a Nokogiri object 
  parse_page=Nokogiri::HTML(page)
  parse_page.css('#search_results > div.content-section-list.infinite-results-list').each do |x|
    x.css('div > div.rest-row-info > div.rest-row-header > a > span').each do |y|
      restaurants << y.text
      puts y.text
    end
  end
end

#getRestaurants()


#configure YELP API 
Yelp.client.configure do |config|
  config.consumer_key = 'bd0yHYKc-8aa3VblSUCoIA'
  config.consumer_secret = 'KxD4qB-tWv6Czm7xQFVQnRRbCu4'
  config.token = 'NABGwKMFmnBTqckOQk-XqY00vwVawJV-'
  config.token_secret = 'GWg89xfq2YFYkrMyG0VmFr5XIhc'
end

def queryRestaurants() 
    full_restaurant_data={} 
    masterlist=["'Cesca", ".Tarallucci e Vino NoMad", ".Tarallucci e Vino Union Square", ".Tarallucci e Vino Upper West Side", "1 Darbar", "2 Darbar Grill", "2 West", "ABC Cocina", "ABC Kitchen", "Ai Fiori", "Almond", "Altesi Downtown", "Altesi Ristorante", "Amada NYC", "American Cut Steakhouse", "American Cut Steakhouse Midtown", "Amma", "Ammos Estiatorio", "Anassa Taverna", "Angus Club Steakhouse", "Antonucci's", "Aretsky's Patroon", "Armani Ristorante 5th Avenue", "Asellina Ristorante", "Astor Court", "Atlantic Grill Near Lincoln Center", "ATRIO Wine Bar | Restaurant", "Aureole", "Bagatelle - NY", "Baita", "Bann Restaurant", "Bar Boulud", "Bar Italia", "Bar Primi", "Barbetta Restaurant", "Barbounia", "Barraca", "Beauty & Essex", "Becco", "bedford murray hill", "Ben and Jack's Steakhouse 44th Street", "Benchmark Restaurant", "Benjamin Steakhouse Prime", "Benoit Restaurant and Bar", "BKW by Brooklyn Winery", "Black Barn", "Blue Fin - New York", "Blue Water Grill", "Bo's Kitchen & Bar Room", "Bobby Van's Grill - 50th Street", "Bobby Van's Steakhouse - 54th Street", "Bobby Van's Steakhouse - Broad Street", "Bocca", "Bocca Di Bacco (Chelsea - 20th St.)", "Bocca di Bacco (Hell's Kitchen - 54th St.)", "Bocca Di Bacco (Theatre District - 45th St.)", "Bodega Negra", "Boucherie", "Boulud Sud", "Brasserie 8 1/2", "Brasserie Cognac", "Brasserie Ruhlmann", "Bread & Tulips", "Burke & Wills", "Butter Midtown", "Buttermilk Channel", "Bâtard", "Cafe d'Alsace", "Café Boulud", "Café Centro", "Calle Ocho", "Capri", "Casa Lever", "Casa Mono", "Casa Nonna - Midtown", "Catch", "Charlie Palmer at The Knick", "Charlie Palmer Steak", "Chazz Palminteri Italian Restaurant", "Cherche Midi", "Chez Josephine", "Churrascaria Plataforma Brazilian Steakhouse", "Cipriani - Dolci", "Cipriani - Wall Street", "Claudette", "Clement", "Club A Steakhouse", "Craft Restaurant", "CUT By Wolfgang Puck at FS Downtown New York", "Danji", "David Burke Kitchen", "Davio's Northern Italian Steakhouse - Manhattan", "db Bistro moderne", "Del Frisco's Double Eagle Steak House - New York City", "Delmonico's", "Delmonico's Kitchen", "Distilled NY", "Docks Oyster Bar and Seafood Grill", "Dos Caminos Park", "Dos Caminos SoHo", "dos caminos midtown east", "Dos Caminos Times Square", "Dos Caminos – Meatpacking", "E&E Grill House", "Edi and The Wolf", "El Toro Blanco", "El Vez New York", "Empellon Taqueria", "Empire Steak House- East", "Empire Steakhouse - 237 West 54 Street off of Broadway", "Esca", "Essex", "Estiatorio Milos - NY", "Etcetera Etcetera", "Farmer & The Fish - Gramercy", "Feast", "Felice 15 Gold Street", "Felice 64 Wine Bar", "Felice 83", "Felidia", "Fifty", "FIG & OLIVE Fifth Avenue", "FIG & OLIVE Meatpacking", "FIG & OLIVE Uptown", "Fish Tag", "Fogo de Chao Brazilian Steakhouse - New York", "Fonda - East Village", "Frankie & Johnnie's Steakhouse - Manhattan", "Frankie and Johnnie's Steakhouse - 46th Street", "French Louie", "Freud - NYC", "Fusco", "Gabriel's Bar & Restaurant", "Gaby Brasserie Française", "Gallaghers Steakhouse - Manhattan", "GAONNURI", "Gin Parlour - InterContinental New York", "Giorgio's of Gramercy", "Giovanni Rana Pastificio & Cucina", "Glass House Tavern", "Gotham Bar and Grill", "Gran Morsi", "Green Fig", "Greenhouse Cafe", "Grotta Azzurra", "Hakkasan - New York", "Hanjan", "Haru Hell's Kitchen", "Haru Sushi - Amsterdam Ave", "Haru Sushi - Chelsea", "Haru Sushi - New York 3rd Avenue", "Hearth", "High Street on Hudson", "Hudson Garden Grill at the New York Botanical Garden", "Hunt & Fish Club NYC", "I Trulli", "Il Buco Alimentari & Vineria", "Il Cantinori", "Il Cortile Restaurant", "Il Mulino New York - Downtown", "Il Mulino New York - Uptown", "Il Mulino Prime", "Il Postino", "ilili", "Inakaya", "Indochine", "Irvington", "Jams", "Jue Lan Club", "Junoon Main Dining Room", "Kefi", "Kellari Taverna", "Khe-Yo", "Kingside", "Kingsley", "La Fonda Del Sol", "La Loteria", "La Masseria", "La Pecora Bianca - Midtown", "La Pecora Bianca - NoMad", "La Sirene", "Lafayette", "Lavo Italian Restaurant", "Le Colonial NYC", "Le Coq Rico", "Left Bank NYC", "LEGASEA", "Leuca", "Lexington Brass", "Lido", "Limani - NYC", "Lincoln Ristorante", "Lincoln Square Steak", "Little Park", "Lorenzo's Restaurant, Bar & Caberet - Hilton Garden Inn - SI", "Lupa", "Lure New York", "Maiella - LIC", "Maloney & Porcelli", "MAMO Restaurant", "MarkJoseph Steakhouse", "Marseille", "Masseria dei Vini", "Massoni", "Match 65 Brasserie (formerly Paris Match)", "Maxwell's Chophouse", "Meet the Meat", "Megu", "Mercer Kitchen", "Michael Jordan's The Steak House N.Y.C.", "Michael's Restaurant", "Molyvos", "Momofuku Má Pêche", "Momofuku Nishi", "Monkey Bar", "Montebello Ristorante Italiano", "Morimoto New York", "Morrell Wine Bar & Cafe", "Morton's The Steakhouse - Midtown Manhattan", "Morton's The Steakhouse - World Trade Center", "MP Taverna - Astoria", "MR CHOW", "MR CHOW - TriBeca", "Mulino a Vino", "Naples 45 Ristorante E Pizzeria", "Narcissa Restaurant", "Natsumi Restaurant", "Neta", "Nice Matin", "Nick & Stef’s Steakhouse - New York", "Nickel & Diner", "Nino's", "Noreetuh", "North Square", "Nougatine at Jean Georges", "Obica Mozzarella Bar  Pizza e Cucina", "Ocean Prime - New York", "ONE Dine", "Orsay", "Ortzi by Jose Garces", "Osteria della Pace - Eataly NYC Downtown", "Ousia", "Pampano New York", "Paowalla", "Park Avenue Winter", "Pera Mediterranean Brasserie", "Pera Soho", "Periyali", "Perry St", "Pig and Khao", "Porsena", "Rafele", "Raymi", "Red Cat", "Red Rooster Harlem", "Remi", "Reserve Cut at Setai", "Restaurant Nippon", "Rice & Gold", "Ristorante Morini", "Riverpark", "Rock Center Cafe", "Root & Bone", "Rosa Mexicano - First Avenue", "Rosa Mexicano - TriBeCa", "Rosa Mexicano - Union Square", "Rosa Mexicano by Lincoln Center", "Rossini's Restaurant", "Rotisserie Georgette", "Rowland's Bar & Grill", "Russian Tea Room - NYC", "Ruth's Chris Steak House - New York City - Midtown", "SAN CARLO  Osteria Piemonte", "Sant Ambroeus - West Village", "Sant Ambroeus SoHo", "Sarabeth's Central Park South", "Sarabeth's East", "Sarabeth's Park Avenue South", "Sarabeth's TriBeCa", "Sarabeth's West", "Scaletta Restaurant", "Schilling", "Sessanta", "Shun Lee Palace", "Shun Lee West", "Smith & Wollensky - New York", "Smoke Jazz and Supper Club", "Socarrat - Chelsea", "Socarrat Midtown East", "Socarrat Paella Bar - Nolita", "Society Cafe", "Sofrito NYC", "STATE Grill and Bar", "Stella 34 Trattoria", "STK - NYC - Meatpacking", "STK - NYC - Midtown", "STK – NYC – Rooftop", "Strip House Midtown", "Strip House Speakeasy", "Sutton Inn", "Suzuki Restaurant", "T-BAR Steak & Lounge (Upper East Side)", "Taboon", "Tamarind - Tribeca", "Tao Downtown", "Tao Uptown", "Tavern 62 by David Burke", "Tavern on the Green", "Temple Court", "Tender Restaurant", "Thalassa", "Thalia", "The Capital Grille - NY – Chrysler Center", "The Capital Grille - NY – Time Life Building", "The Capital Grille - NY- Wall Street", "The Cecil Steakhouse", "The Clocktower", "The Dining Room at The Metropolitan Museum of Art", "The Dutch", "The House", "The Lambs Club - Bar", "The Leopard at des Artistes", "The Library at the Public", "The Morgan Dining Room", "The National Bar & Dining Rooms", "The Palm Tribeca", "The Sea Grill", "The Shakespeare", "The Stanton Social", "The Tuck Room- New York", "The View Restaurant", "The Wayfarer", "The Writing Room", "Tiny's & the Bar Upstairs", "Toloache Thompson St.", "Toloache 50", "Tommy Bahama - New York", "Trattoria Il Mulino", "Trattoria Zero Otto Nove", "Tribeca Grill", "Triomphe", "Tuome", "Tutto Il Giorno -Tribeca", "Untitled at the Whitney", "Vandal", "Vaucluse", "ViceVersa", "Victor's Café", "Vinateria", "Wollensky’s Grill", "Yellow Magnolia Café", "Yves", "Zengo - NYC", "Zio Ristorante", "Zuma Japanese Restaurant - NY"]
    masterlist.each_with_index do |restaurant, index|
      masterlist[index]=restaurant.gsub('&'," ")
    end
    masterlist.each_with_index do |restaurant,index|
      response= Yelp.client.search( 'Manhattan, NY', { term: masterlist[index], limit: 1  })
      business=response.businesses[0]
      if (defined? business.name)
        categories = []
        business.categories.each do | category | 
           categories << category[0] 
        end 
        full_restaurant_data[business.name]={ name: business.name, rating: business.rating, review_count: business.review_count, categories: categories, address: business.location.display_address, url: business.url}
        puts business.name
      end
    end
    File.open("rest.json","w") do |f|
      f.write(JSON.pretty_generate(full_restaurant_data))
    end
end

queryRestaurants()
   



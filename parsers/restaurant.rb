code = "
  await sleep(3000);
"
parsable = true

if false
  # refetch_count = (page['vars']['refetch_count'].nil?)? 1 : page['vars']['refetch_count'] + 1
  # if refetch_count < 2
  #   pages << {
  #     url: page['url'],
  #     page_type: 'restaurant',
  #     fetch_type: "browser",
  #     driver: {
  #       name: "refetch",
  #       enable_images: true,
  #     },
  #     http2: true,
  #     vars: {
  #       country: page['vars']['country'],
  #       position: page['vars']['position'],
  #       refetch_count: refetch_count
  #     }
  #   }
  # else
  #   raise 'refetch failed'
  # end
else
  # require 'byebug'
  # byebug
  def uuid_v3(uuid_namespace, name)
    version = 3

    hash = Digest::MD5.new
    hash.update(uuid_namespace)
    hash.update(name)

    ary = hash.digest.unpack("NnnnnN")
    ary[2] = (ary[2] & 0x0FFF) | (version << 12)
    ary[3] = (ary[3] & 0x3FFF) | 0x8000

    "%08x-%04x-%04x-%04x-%04x%08x" % ary
  end
  
  # unwanted_cuisines = [
  #   "Hair Salons","Gyms","Printing Services","Hotels","Massage","Cards & Stationery",
  #   "Yoga","Men's Clothing","Art Galleries","Bookstores","Nail Salons","Museums","Performing Arts",
  #   "Furniture Stores","Sports Wear","Hair Stylists","Hair Removal","Lounges","Art Supplies",
  #   "Cosmetics & Beauty Supply","Opera & Ballet","Estheticians","Women's Clothing","Music Venues",
  #   "Men's Hair Salons","Office Equipment","Arts & Crafts","Stadiums & Arenas","Leather Goods",
  #   "Interior Design","Landmarks & Historical Buildings","Social Clubs","Toy Stores","Trainers",
  #   "Accessories","Mattresses","Swimming Pools","Sports Clubs","Tattoo","Used, Vintage & Consignment",
  #   "Arts & Entertainment","Makeup Artists","Active Life","Golf","Bike Repair/Maintenance","Boxing",
  #   "Airport Lounges","Fabric Stores","Cultural Center","Betting Centers","Swimming Lessons/Schools",
  #   "Day Spas","Venues & Event Spaces","Art Museums","Martial Arts","Building Supplies","Car Wash",
  #   "Wholesale Stores","Architectural Tours","Waxing","Furniture Repair","Mass Media",
  #   "Fitness & Instruction","Amateur Sports Teams","Department Stores","Books, Mags, Music & Video",
  #   "Sporting Goods","Claimed","Building Supplies", "Laundry Services", "Windows Installation"
  # ]
  # not_cuisines = ["Hair Salons","Gyms","Printing Services","Hotels","Massage","Cards & Stationery",
  #   "Yoga","Men's Clothing","Art Galleries","Bookstores","Nail Salons","Museums","Performing Arts",
  #   "Furniture Stores","Sports Wear","Hair Stylists","Hair Removal","Lounges","Art Supplies",
  #   "Cosmetics & Beauty Supply","Opera & Ballet","Estheticians","Women's Clothing","Music Venues",
  #   "Men's Hair Salons","Office Equipment","Arts & Crafts","Stadiums & Arenas","Leather Goods",
  #   "Interior Design","Landmarks & Historical Buildings","Social Clubs","Toy Stores","Trainers",
  #   "Accessories","Mattresses","Swimming Pools","Sports Clubs","Tattoo","Used, Vintage & Consignment",
  #   "Arts & Entertainment","Makeup Artists","Active Life","Golf","Bike Repair/Maintenance","Boxing",
  #   "Airport Lounges","Fabric Stores","Cultural Center","Betting Centers","Swimming Lessons/Schools",
  #   "Day Spas","Venues & Event Spaces","Art Museums","Martial Arts","Building Supplies","Car Wash",
  #   "Wholesale Stores","Architectural Tours","Waxing","Furniture Repair","Mass Media","Fitness & Instruction",
  #   "Amateur Sports Teams","Department Stores","Books, Mags, Music & Video","Sporting Goods","Claimed",
  #   "Music & DVDs","Food Stands", "Kiosk","Bistros","Beaches","Grocery","Vegan","Buffets",
  #   "Bars","Local Flavor","Gluten-Free","Wine Bars","Medical Spas","Farmers Market","Sushi Bars","Recreation Centers",
  #   "Pubs","Used Bookstore","Comfort Food","Parks","Dog Parks","Coffee Roasteries","Cinema","Tex-Mex", 
  #   "Post Offices","Community Service/Non-Profit","Pan Asian","Tea Rooms","Shoe Repair","Tapas/Small Plates",
  #   "Gay Bars","Public Transportation","Home Decor","Electronics","Asian Fusion","Public Services & Government",
  #   "Cafeteria","Candy Stores","Lakes","Antiques","Skin Care","Chocolatiers & Shops","Festivals","Skate Parks",
  #   "Shopping","Caterers","Delis","Street Vendors","Organic Stores","Local Services","Skating Rinks",
  #   "Dance Clubs","Bowling","Dive Bars","Bed & Breakfast","Beer Bar","Jewelry","Karaoke",
  #   "Souvenir Shops","Speakeasies","Hiking","Traditional Chinese Medicine","Education",
  #   "Health & Medical","Flea Markets","Hobby Shops","Barbers","Outlet Stores","Boating",
  #   "Framing","Youth Club","Ski Resorts","Chicken Shop","Amusement Parks","Creperies","Sports Bars","Hotel bar",
  #   "Train Stations","Cheese Shops","Comedy Clubs","Luggage","Pets","Knitting Supplies","Boat Charters",
  #   "Hotels & Travel","Mobile Phones","Canteen","Irish Pub","Jazz & Blues","Discount Store","Shoe Stores",
  #   "Airports","Outdoor Gear","Nightlife","Professional Services","Fashion","Specialty Food","Mountain Biking",
  #   "Scandinavian Design","Food Trucks","Playgrounds","Physical Therapy","Religious Organizations","Fruits & Veggies",
  #   "Beer, Wine & Spirits","Cafes","Diners","Eyelash Service","Convenience Stores","Shopping Centers","Bike Rentals",
  #   "Buddhist Temples","Western Style Japanese Food","International","Bartending Schools","Hot Pot","Herbs & Spices",
  #   "Rest Stops","Botanical Gardens","Climbing","Historical Tours","Zoos","Castles","Tapas Bars","Local Fish Stores",
  #   "Chiropractors","Gyudon","Bagels","Sake Bars","Kids Activities","Whiskey Bars","Hookah Bars","Gift Shops","Food",
  #   "Food Court","Meat Shops","Halal","Turkish","Acupuncture","Themed Cafes","Indoor Playcentre","Nurseries & Gardening",
  #   "Barbeque","Arcades","Libraries","Guest Houses","Adult","Guitar Stores","Massage Therapy","Bathing Area",
  #   "Laser Hair Removal","Butcher","British","Mediterranean","Eyewear & Opticians","Laotian","Drugstores","Onigiri",
  #   "Florists","Pancakes","Hungarian","Recycling Center","Cooking Classes","Tofu Shops","Appliances","Adult Entertainment",
  #   "Pet Stores","Seafood Markets","Bikes","Police Departments","Security Services","Party Supplies","Computers",
  #   "Watches","Specialty Schools","Thrift Stores","Wineries","Party & Event Planning","Aquariums","Tobacco Shops",
  #   "Eyebrow Services","Pool & Billiards","Dance Wear","Basketball Courts","Observatories","Home & Garden",
  #   "Live/Raw Food","Tours","Tennis","Beauty & Spas","Strip Clubs","Permanent Makeup","Pet Groomers","Pakistani",
  #   "Pasta Shops","Metro Stations","Baby Gear & Furniture","Pharmacy","Hostels","Personal Shopping","Soccer",
  #   "Video Game Stores","Child Care & Day Care","Duty-Free Shops","Resorts","Race Tracks","Counseling & Mental Health",
  #   "Clothing Rental","Pet Sitting","Pet Services","Colleges & Universities","Imported Food","Champagne Bars",
  #   "Travel Services","Videos & Video Game Rental","Photography Stores & Services","Departments of Motor Vehicles",
  #   "Beer Gardens","Health Markets","Campgrounds","Food Delivery Services","Funeral Services & Cemeteries",
  #   "Session Photography","Dagashi","Skate Shops","Gas Stations","Bento","Public Art","Horseback Riding","Lingerie",
  #   "Perfume", "Coffee & Tea Supplies","Comic Books","Children's Clothing","Filipino","Magicians","Shared Office Spaces",
  #   "Hospitals","Greek","Do-It-Yourself Food","Transportation","Hardware Stores","Bulgarian","Software Development",
  #   "Pool Halls","Visitor Centers","Popcorn Shops","Educational Services","Steakhouses","American (Traditional)",
  #   "Newspapers & Magazines","Desserts","Island Pub","Game Meat","Brasseries","Dance Studios","Mini Golf","Pilates",
  #   "Open Sandwiches","Churches","Fondue","Lighting Fixtures & Equipment","Banks & Credit Unions","Kitchen & Bath",
  #   "Baguettes","Latin American","African","Internet Cafes","Bridal","Polish","Flowers & Gifts","Insurance","Cuban",
  #   "Basque","Optometrists","Preschools","Hair Extensions","Medical Centers","Signature Cuisine","Pop-Up Restaurants",
  #   "Boot Camps","Russian","Financial Services","Couriers & Delivery Services","Marketing","Australian","Bangladeshi",
  #   "Swimwear","Experiences","Furniture Reupholstery","Musical Instruments & Teachers","Airport Shuttles","Lawn Bowling",
  #   "Weight Loss Centers","Fitness/Exercise Equipment","Car Rental","Poke","Bubble Tea","Kurdish","Tanning","Cantonese",
  #   "Dance Schools","Public Markets","Rafting/Kayaking","Gelato","Paintball","Vinyl Records","IT Services & Computer Repair",
  #   "Fast Food","Pensions","Bakeries","Brewpubs","Vacation Rentals","Beer Garden","Dinner Theater","Serbo Croatian",
  #   "Pawn Shops","Accountants","Apartments","Mountain Huts","Shipping Centers","Home Health Care","Watch Repair",
  #   "Piercing","Soup","Professional Sports Teams","Community Centers","Public Plazas","German","Falafel", "Building Supplies", "Laundry Services", "Windows Installation"
  # ]

  # if page['failed_response_status_code']
  #   raise '503'
  #   refetch page['gid']
  #   parsable = false
  # end

  html = Nokogiri::HTML(content)
  json = html.search('script[type="application/ld+json"]').inject({}){|a,b| a.merge JSON.parse(b)} rescue nil
  # byebug
  # begin
  #   unless html.at('span.page-status:contains("404 error")').nil?
  #     parsable = false
  #   end
  #   if html.at('h1').nil?
  #     refetch page['gid']
  #     parsable = false
  #   end
  #   if json['address'].nil?
  #     refetch page['gid']
  #     parsable = false
  #   end
  unless json['address']["addressCountry"].nil?
    if json['address']["addressCountry"] != page['vars']['country']
      parsable = false
    end
  end
  
  uid = html.at('meta[name="yelp-biz-id"]')['content'] rescue nil

  #   if uid.nil?
  #     refetch page['gid']
  #     parsable = false
  #   end
  # rescue => e
  #   puts e.message
  #   raise
  #   parsable = false
  # end

  if parsable
    if !json.nil?
      name = json['name']

      street_1 = json['address']['streetAddress'].gsub(/\s+/, ' ') rescue nil
      city = json['address']['addressLocality']
      state = json['address']['addressRegion']
      zip = json['address']['postalCode'].gsub('〒', '') rescue nil
      country = json['address']['addressCountry']
      phone = json['telephone']

      rating = json['aggregateRating']['ratingValue'] rescue nil
      reviews_count = json['aggregateRating']['reviewCount'] rescue 0

      price_category = json['priceRange']

      main_cuisine = json['servesCuisine']
    end
    
    cuisines = html.search('span.category-str-list a').map{|cat| cat.text.strip.gsub(/\\u([a-f0-9]{4,5})/i){ [$1.hex].pack('U') }}.uniq rescue []

    if cuisines.nil? || cuisines.count == 0
      cuisines = html.search('div:has(h1) ~ span a').map{|a| a.text}
    end
    cuisines.shift if cuisines.first == 'Unclaimed'
    
    # main_cuisine = ([main_cuisine] + cuisines).compact.first

    # cuisines = []
    # html.search('script[type="application/ld+json"]').each do |js|
    #   cs_json = JSON.parse(js)
    #   if cs_json.include? "itemListElement"
    #     cuisines << cs_json['itemListElement'][1]['item']['name'].gsub("amp;", '') rescue nil
    #   end
    # end
    
    # cuisines = ([main_cuisine] + cuisines).compact - not_cuisines rescue []
    
    # if cuisines.empty?
    #   main_cuisine = main_cuisine_origin
    # end
    
    if rating.nil?
      rating = html.at('div.photoHeader__373c0__1lZx8 div.i-stars__373c0___sZu0')['aria-label'][/([\d\.]+) star/, 1].to_f rescue nil
      rating ||= html.at('div.arrange-unit__373c0__3S8rT.arrange-unit-fill__373c0__24Gfj div.i-stars__373c0___sZu0')['aria-label'][/([\d\.]+) star/, 1].to_f rescue nil
      rating ||= Float(html.at('div[class*="photoHeader"] div[class*="five-stars"]')['aria-label'][/([\d\.]+) star/, 1]) rescue nil
      rating ||= Float(html.at('main#main-content:first-child div[class*="five-stars"]')['aria-label'][/([\d\.]+) star/, 1]) rescue nil
      rating ||= Float(html.at('yelp-react-root > div > div[class*="arrange"] div[class*="five-stars"]')['aria-label'][/([\d\.]+) star/, 1]) rescue nil

      
      reviews_count = html.at('div.photoHeader__373c0__1lZx8 span.css-bq71j2:contains("review")').text[/(\d+) review/, 1].to_i rescue nil
      reviews_count ||= html.at('div.arrange-unit__373c0__3S8rT.arrange-unit-fill__373c0__24Gfj span.css-1h1j0y3:contains("review")').text[/(\d+) review/, 1].to_i rescue nil
      reviews_count ||= Integer(html.at('div#reviews div[class*="rating-text"] p').text[/(\d+) review/i, 1]) rescue nil
      reviews_count ||= Integer(html.css('div[class*="photoHeader"] span').find{|t| t.text =~ /\d+ review/i}.text[/(\d+) review/, 1]) rescue nil
      reviews_count ||= Integer(html.css('main#main-content:first-child span').find{|t| t.text =~ /\d+ review/i}.text[/(\d+) review/, 1]) rescue nil
    end

    lat, long = html.at('a.biz-map-directions img[alt="Map"]')['src'].scan(/center=([\-\.\d]+)%2C([\-\.\d]+)&/).first rescue [nil, nil]
    lat, long = html.at('section:contains("Location") img[alt="Map"]')['src'].scan(/center=([\-\.\d]+)%2C([\-\.\d]+)&/).first rescue [nil, nil] if lat.nil?

    hours_sel = html.search('table.table--simple__373c0__3QsR_.hours-table__373c0__2YHlD tr:has(th)')
    hours = hours_sel.inject({}) do |a,b|
      key = b.at('th').text[0..2]
      value = b.search('td ul li p').map(&:text).map do |range|
        if range =~ /24 hours/i
          '0000-0000'
        else
          range.split('-').map do |d|
            time = Time.parse(Nokogiri::HTML(d.strip).text).strftime("%H%M")
          end.join('-')
        end
      end rescue nil
      a.merge({key => value})
    end.delete_if{|a,b| b.nil? || b.empty?}

    if hours_sel.empty?
      hours = html.search('table[class*="hours-table"] tr:has(th)').inject({}) do |a,b|
        key = b.at('th').text[0..2]
        value = b.search('td ul li p').map(&:text).map do |range|
          if range =~ /24 hours/i
            '0000-0000'
          else
            range.split('-').map do |d|
              time = Time.parse(Nokogiri::HTML(d.strip).text).strftime("%H%M")
            end.join('-')
          end
        end rescue nil
        a.merge({key => value})
      end.delete_if{|a,b| b.nil? || b.empty?}
    end

    # delivery = html.at('div:has(span:contains("Offers Delivery"))').at('span:contains("Yes")') != nil rescue false

    uuid = uuid_v3("yelp_#{page['vars']['country'].downcase}", uid)
    id_dedup = "#{CGI.unescapeHTML(name)}_#{street_1}_#{city}"

    tags = html.to_html.scan(/0\.properties\.\d+.+?displayText&quot;:&quot;(.+?)&quot;/).flatten
    delivery = tags.include?('Offers Delivery')

    # if !cuisines.nil? && !cuisines&.empty?
    #   # not_cuisines = ["Home & Garden", "Arcades", "Dance Clubs", "Caterers", "Fuel Docks", "Stadiums & Arenas", "Pop-Up Restaurants", "Landmarks & Historical Buildings", "Fashion", "Parks", "Flowers & Gifts", "Convenience Stores", "Fishing", "Bars", "Grocery", "Mini Golf", "Pool Halls", "Vacation Rental Agents", "Eyewear & Opticians", "Food Delivery Services", "Baby Gear & Furniture", "Transportation", "Organic Stores", "Recreation Centers", "Sporting Goods", "Flea Markets", "Bike Repair/Maintenance", "Food Court", "Electronics", "Shopping Centers", "Adult", "Hostels", "Hair Salons", "Books, Mags, Music & Video", "Internet Cafes", "Day Spas", "Jazz & Blues", "Ethical Grocery", "Irish", "Bridal", "Bathing Area", "Golf", "Bistros", "Fitness & Instruction", "Horseback Riding", "Beaches", "Post Offices", "Optometrists", "Bike Rentals", "Antiques", "Community Service/Non-Profit", "Preschools", "Kids Activities", "Hospitals", "Train Stations", "Mountain Biking", "Counseling & Mental Health", "Tobacco Shops", "Nail Salons", "Boat Charters", "Castles", "Hobby Shops", "Lakes", "Tours", "Boating", "Knitting Supplies", "Rafting/Kayaking", "Guest Houses", "Skin Care", "Accountants", "Marketing", "Bowling", "Child Care & Day Care", "Karaoke", "Steakhouses", "Libraries", "Public Art", "Festivals", "Scandinavian", "Playgrounds", "Jewelry", "Souvenir Shops", "Interior Design", "Skating Rinks", "Aquariums", "Pet Services", "Physical Therapy", "Thrift Stores", "Discount Store", "Lawn Bowling", "Weight Loss Centers", "Fitness/Exercise Equipment", "Outlet Stores", "Car Rental", "Pet Stores", "Indoor Playcentre", "Soccer", "Couriers & Delivery Services", "Community Centers", "Distilleries", "Colleges & Universities", "Insurance", "Farmers Market", "Specialty Schools", "Public Markets", "Signature Cuisine", "Resorts", "Acupuncture", "Musical Instruments & Teachers", "Art Classes", "Comedy Clubs", "Pharmacy", "Lighting Fixtures & Equipment", "IT Services & Computer Repair", "Ice Cream & Frozen Yogurt", "Party Supplies", "Wholesale Stores", "Toy Stores", "Cosmetics & Beauty Supply", "Department Stores", "Kiosk", "Cards & Stationery", "Botanical Gardens", "Delicatessen", "Car Wash", "Traditional Chinese Medicine", "Watches", "Venues & Event Spaces", "Computers", "Amusement Parks", "Mobile Phones", "Tickets", "Hotels", "Medical Foot Care", "Food Trucks", "Zoos", "Experiences", "Sewing & Alterations", "Real Estate", "Music Venues", "Luggage", "Performing Arts", "Youth Club", "Party & Event Planning", "Butcher", "Sports Clubs", "Cultural Center", "Arts & Crafts", "Wedding Planning", "Museums", "Nutritionists", "Laser Tag", "Head Shops", "Gas Stations", "Photography Stores & Services", "Modern European", "Watch Repair", "Educational Services", "Cinema", "Ski Resorts", "Street Vendors", "Chinese", "Art Galleries", "International Grocery", "Electronics Repair", "Furniture Reupholstery", "Betting Centers", "Doctors", "Surfing", "Personal Shopping", "Swimming Pools", "Graphic Design", "Social Clubs", "Adult Education", "Contractors", "Electricians", "Plumbing", "Painters", "Roofing", "General Contractors", "Private Schools", "Campgrounds", "Cafes", "Vacation Rentals", "Saunas", "Travel Services", "Smokehouse", "Advertising", "Home Cleaning", "Car Dealers", "Web Design", "Spiritual Shop", "Heating & Air Conditioning/HVAC", "Farms", "Tires", "Churches", "Elementary Schools", "Employment Agencies", "Flooring", "Public Relations", "Photographers", "Island Pub", "Print Media", "Appliances & Repair", "Video/Film Production", "Architects", "Tree Services", "Food Stands", "Hiking", "Lawyers", "Skiing", "Tennis", "Massage", "Chiropractors", "Landscaping", "Go Karts", "Auto Parts & Supplies", "Casinos", "Dentists", "Climbing", "Animal Shelters", "Gun/Rifle Ranges", "Solar Installation", "Auto Repair", "Polish", "Musicians", "Carpeting"]
    #   # not_cuisines.uniq!

    #   cuisines = cuisines
    #   main_cuisine = cuisines.first
    # end

    cuisines = nil if cuisines.empty?
    
    if json['address']["addressCountry"] == page['vars']['country']
      if main_cuisine.nil?
        location = {
          _collection: 'non-related',
          _id: id_dedup,
          date: Time.parse(page['fetched_at']).strftime('%Y%m%d %H:%M:%S'),
          lead_id: uuid,
          url: page['url'],
          restaurant_name: CGI.unescapeHTML(name), 
  
          price_category: price_category,
          restaurant_address: street_1.empty? ? nil : street_1,
          restaurant_city: city.empty? ? nil : city,
          restaurant_area: state.nil? || state.empty? ? nil : state,
          restaurant_post_code: zip.nil? ? nil : zip,
          restaurant_country: country,
          restaurant_lat: (Float(lat) rescue nil),
          restaurant_long: (Float(long) rescue nil),
          phone_number: (phone&.empty? ? nil : phone),
          restaurant_delivers: delivery,
          # restaurant_overall_rating: (html.at('span.overallRating').text.strip rescue nil),
          restaurant_rating: (rating ? rating.to_f : nil),
          restaurant_position: nil,
          number_of_ratings: reviews_count,
          main_cuisine: main_cuisine,
          cuisine_name: cuisines&.uniq,
          opening_hours: (hours&.empty? ? nil : hours),
          restaurant_tags: (tags&.empty? ? nil : tags.map{|t| CGI.unescapeHTML(t)}),
          restaurant_delivery_zones: delivery ? [{"delivery_zone": nil,"minimum_order_value": nil,"delivery_fee": nil,"currency": "#{ENV['currency_code']}"}] : nil,
          free_field: {
            website: (html.search('div:has(p:contains("Business website"))').last.text[/http.+/] rescue nil)
          }
        }
        outputs << location
        save_outputs outputs if outputs.length > 99
      else
        location = {
          _collection: 'locations',
          _id: id_dedup,
          date: Time.parse(page['fetched_at']).strftime('%Y%m%d %H:%M:%S'),
          lead_id: uuid,
          url: page['url'],
          restaurant_name: CGI.unescapeHTML(name), 

          price_category: price_category,
          restaurant_address: street_1.empty? ? nil : street_1,
          restaurant_city: city.empty? ? nil : city,
          restaurant_area: state.nil? || state.empty? ? nil : state,
          restaurant_post_code: zip.nil? ? nil : zip,
          restaurant_country: country,
          restaurant_lat: (Float(lat) rescue nil),
          restaurant_long: (Float(long) rescue nil),
          phone_number: (phone&.empty? ? nil : phone),
          restaurant_delivers: delivery,
          restaurant_rating: (rating ? rating.to_f : nil),
          restaurant_position: nil,
          number_of_ratings: reviews_count,
          main_cuisine: main_cuisine,
          cuisine_name: cuisines&.uniq,
          opening_hours: (hours&.empty? ? nil : hours),
          restaurant_tags: (tags&.empty? ? nil : tags.map{|t| CGI.unescapeHTML(t)}),
          restaurant_delivery_zones: delivery ? [{"delivery_zone": nil,"minimum_order_value": nil,"delivery_fee": nil,"currency": "#{ENV['currency_code']}"}] : nil,
          free_field: {
            website: (html.search('div:has(p:contains("Business website"))').last.text[/http.+/] rescue nil)
          }
        }
        outputs << location
        save_outputs outputs if outputs.length > 99

        pages << {
          url: page['url'].gsub(/\/$/, '') + "/props",
          page_type: 'props',
          fetch_type: "standard",
          priority: 500,
          headers: {
            'accept': 'application/json',
            'accept-language': 'en-US,en;q=0.9,ru;q=0.8',
            'cache-control': 'no-cache',
            'content-type': 'application/json',
            'pragma': 'no-cache',
            'referer': page['url'],
            'sec-ch-ua': '"Chromium";v="110", "Not A(Brand";v="24", "Microsoft Edge";v="110"',
            'sec-ch-ua-mobile': '?0',
            'sec-ch-ua-platform': '"Windows"',
            'sec-fetch-dest': 'empty',
            'sec-fetch-mode': 'cors',
            'sec-fetch-site': 'same-origin',
            'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.50',
            'x-requested-with': 'XMLHttpRequest'
          },
          http2: true,
          vars: page['vars'].merge({
            "parent_gid" => page['gid'],
            # "location" => location
          }),
        } 
        save_pages pages if pages.count > 99
      end
    end
  end
end

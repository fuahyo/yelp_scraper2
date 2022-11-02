parsable = true
if false
  refetch_count = (page['vars']['refetch_count'].nil?)? 1 : page['vars']['refetch_count'] + 1
  if refetch_count < 2
    pages << {
      url: page['url'],
      page_type: 'restaurant',
      fetch_type: "browser",
  #     headers: {
  # "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36",
  #       "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
  #     },
      driver: {
        name: "refetch",
        enable_images: true,
      },
      http2: true,
      vars: {
        country: page['vars']['country'],
        position: page['vars']['position'],
        refetch_count: refetch_count
      }
    }
  else
    raise 'refetch failed'
  end
else
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

  unwanted_cuisines = [
    "Hair Salons","Gyms","Printing Services","Hotels","Massage","Cards & Stationery",
    "Yoga","Men's Clothing","Art Galleries","Bookstores","Nail Salons","Museums","Performing Arts",
    "Furniture Stores","Sports Wear","Hair Stylists","Hair Removal","Lounges","Art Supplies",
    "Cosmetics & Beauty Supply","Opera & Ballet","Estheticians","Women's Clothing","Music Venues",
    "Men's Hair Salons","Office Equipment","Arts & Crafts","Stadiums & Arenas","Leather Goods",
    "Interior Design","Landmarks & Historical Buildings","Social Clubs","Toy Stores","Trainers",
    "Accessories","Mattresses","Swimming Pools","Sports Clubs","Tattoo","Used, Vintage & Consignment",
    "Arts & Entertainment","Makeup Artists","Active Life","Golf","Bike Repair/Maintenance","Boxing",
    "Airport Lounges","Fabric Stores","Cultural Center","Betting Centers","Swimming Lessons/Schools",
    "Day Spas","Venues & Event Spaces","Art Museums","Martial Arts","Building Supplies","Car Wash",
    "Wholesale Stores","Architectural Tours","Waxing","Furniture Repair","Mass Media",
    "Fitness & Instruction","Amateur Sports Teams","Department Stores","Books, Mags, Music & Video",
    "Sporting Goods","Claimed"
  ]
  not_cuisines = ["Hair Salons","Gyms","Printing Services","Hotels","Massage","Cards & Stationery","Yoga","Men's Clothing","Art Galleries","Bookstores","Nail Salons","Museums","Performing Arts","Furniture Stores","Sports Wear","Hair Stylists","Hair Removal","Lounges","Art Supplies","Cosmetics & Beauty Supply","Opera & Ballet","Estheticians","Women's Clothing","Music Venues","Men's Hair Salons","Office Equipment","Arts & Crafts","Stadiums & Arenas","Leather Goods","Interior Design","Landmarks & Historical Buildings","Social Clubs","Toy Stores","Trainers","Accessories","Mattresses","Swimming Pools","Sports Clubs","Tattoo","Used, Vintage & Consignment","Arts & Entertainment","Makeup Artists","Active Life","Golf","Bike Repair/Maintenance","Boxing","Airport Lounges","Fabric Stores","Cultural Center","Betting Centers","Swimming Lessons/Schools","Day Spas","Venues & Event Spaces","Art Museums","Martial Arts","Building Supplies","Car Wash","Wholesale Stores","Architectural Tours","Waxing","Furniture Repair","Mass Media","Fitness & Instruction","Amateur Sports Teams","Department Stores","Books, Mags, Music & Video","Sporting Goods","Claimed","Restaurants","Scandinavian","Music & DVDs","Food Stands","Gastropubs","Kiosk","Bistros","Beaches","Grocery","Vegan","Buffets","Bars","Local Flavor","Gluten-Free","Wine Bars","Medical Spas","Farmers Market","Sushi Bars","Recreation Centers","Pubs","Used Bookstore","Comfort Food","Parks","Dog Parks","Coffee Roasteries","Cinema","Tex-Mex","Cocktail Bars","Post Offices","Community Service/Non-Profit","Pan Asian","Tea Rooms","Shoe Repair","Tapas/Small Plates","Gay Bars","Public Transportation","Home Decor","Electronics","Asian Fusion","Public Services & Government","Cafeteria","Candy Stores","Lakes","Antiques","Skin Care","Chocolatiers & Shops","Festivals","Skate Parks","Shopping","Caterers","Delis","Street Vendors","Organic Stores","Local Services","Skating Rinks","Dance Clubs","Bowling","Dive Bars","Bed & Breakfast","Beer Bar","Jewelry","Karaoke","Souvenir Shops","Speakeasies","Hiking","Traditional Chinese Medicine","Education","Health & Medical","Flea Markets","Hobby Shops","Barbers","Outlet Stores","Boating","Framing","Youth Club","Ski Resorts","Chicken Shop","Amusement Parks","Creperies","Sports Bars","Hotel bar","Train Stations","Cheese Shops","Comedy Clubs","Luggage","Pets","Knitting Supplies","Boat Charters","Hotels & Travel","Mobile Phones","Canteen","Irish Pub","Jazz & Blues","Discount Store","Shoe Stores","Airports","Outdoor Gear","Nightlife","Professional Services","Fashion","Specialty Food","Mountain Biking","Scandinavian Design","Food Trucks","Playgrounds","Physical Therapy","Religious Organizations","Fruits & Veggies","Beer, Wine & Spirits","Cafes","Diners","Eyelash Service","Convenience Stores","Shopping Centers","Bike Rentals","Buddhist Temples","Western Style Japanese Food","International","Bartending Schools","Hot Pot","Herbs & Spices","Rest Stops","Botanical Gardens","Climbing","Historical Tours","Zoos","Castles","Tapas Bars","Local Fish Stores","Chiropractors","Gyudon","Bagels","Sake Bars","Kids Activities","Whiskey Bars","Hookah Bars","Gift Shops","Food","Food Court","Meat Shops","Halal","Turkish","Acupuncture","Themed Cafes","Indoor Playcentre","Nurseries & Gardening","Barbeque","Arcades","Libraries","Guest Houses","Adult","Guitar Stores","Massage Therapy","Bathing Area","Laser Hair Removal","Butcher","British","Mediterranean","Eyewear & Opticians","Laotian","Drugstores","Onigiri","Florists","Pancakes","Hungarian","Recycling Center","Cooking Classes","Tofu Shops","Appliances","Adult Entertainment","Pet Stores","Seafood Markets","Bikes","Police Departments","Security Services","Party Supplies","Computers","Watches","Specialty Schools","Thrift Stores","Wineries","Party & Event Planning","Aquariums","Tobacco Shops","Eyebrow Services","Pool & Billiards","Dance Wear","Basketball Courts","Observatories","Home & Garden","Live/Raw Food","Tours","Tennis","Beauty & Spas","Strip Clubs","Permanent Makeup","Pet Groomers","Pakistani","Pasta Shops","Metro Stations","Baby Gear & Furniture","Pharmacy","Hostels","Personal Shopping","Soccer","Video Game Stores","Child Care & Day Care","Duty-Free Shops","Resorts","Race Tracks","Counseling & Mental Health","Clothing Rental","Pet Sitting","Pet Services","Colleges & Universities","Imported Food","Champagne Bars","Travel Services","Videos & Video Game Rental","Photography Stores & Services","Departments of Motor Vehicles","Beer Gardens","Health Markets","Campgrounds","Food Delivery Services","Funeral Services & Cemeteries","Session Photography","Dagashi","Skate Shops","Gas Stations","Bento","Public Art","Horseback Riding","Lingerie","Perfume","Coffee & Tea Supplies","Comic Books","Children's Clothing","Filipino","Magicians","Shared Office Spaces","Hospitals","Greek","Do-It-Yourself Food","Transportation","Hardware Stores","Bulgarian","Software Development","Pool Halls","Visitor Centers","Popcorn Shops","Educational Services","Steakhouses","American (Traditional)","Newspapers & Magazines","Desserts","Island Pub","Game Meat","Brasseries","Dance Studios","Mini Golf","Pilates","Open Sandwiches","Churches","Fondue","Lighting Fixtures & Equipment","Banks & Credit Unions","Kitchen & Bath","Baguettes","Latin American","African","Internet Cafes","Bridal","Polish","Flowers & Gifts","Insurance","Cuban","Basque","Optometrists","Preschools","Hair Extensions","Medical Centers","Signature Cuisine","Pop-Up Restaurants","Boot Camps","Russian","Financial Services","Couriers & Delivery Services","Marketing","Australian","Bangladeshi","Swimwear","Experiences","Furniture Reupholstery","Musical Instruments & Teachers","Airport Shuttles","Lawn Bowling","Weight Loss Centers","Fitness/Exercise Equipment","Car Rental","Poke","Bubble Tea","Kurdish","Tanning","Cantonese","Dance Schools","Public Markets","Rafting/Kayaking","Gelato","Paintball","Vinyl Records","IT Services & Computer Repair","Fast Food","Pensions","Bakeries","Brewpubs","Vacation Rentals","Beer Garden","Dinner Theater","Serbo Croatian","Pawn Shops","Accountants","Apartments","Mountain Huts","Shipping Centers","Home Health Care","Watch Repair","Piercing","Soup","Professional Sports Teams","Community Centers","Public Plazas","German","Falafel"]

  if page['failed_response_status_code']
    raise '503'
    refetch page['gid']
    parsable = false
  end

  html = Nokogiri::HTML(content)
  json = html.search('script[type="application/ld+json"]').inject({}){|a,b| a.merge JSON.parse(b)} rescue nil

  begin
    unless html.at('span.page-status:contains("404 error")').nil?
      parsable = false
    end
    if html.at('h1').nil?
      refetch page['gid']
      parsable = false
    end
    # if html.at('h1').text.strip == "See you later!"
    #   redirect = CGI::parse(page['url'])['redirect_url'].first
    #   $mongo_pool["#{parser_page[:source_name]}_pages"].find(_id: parser_page[:_id]).update_one('$set' => {url: redirect})
    #   refetch page['gid']
    #   parsable = false
    # end
    if json['address'].nil?
      refetch page['gid']
      parsable = false
    end

    if json['address']["addressCountry"] != page['vars']['country']
      parsable = false
    end

    uid = html.at('meta[name="yelp-biz-id"]')['content'] rescue nil

    if uid.nil?
      refetch page['gid']
      parsable = false
    end
  rescue => e
    puts e.message
    raise
    parsable = false
  end

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

      cuisine = json['servesCuisine']

      price_category = json['priceRange']

      main_cuisine = json['servesCuisine']
    end

    cuisines = html.search('span.category-str-list a').map{|cat| cat.text.strip.gsub(/\\u([a-f0-9]{4,5})/i){ [$1.hex].pack('U') }}.uniq rescue []

    if cuisines == nil || cuisines.count == 0
      cuisines = html.search('div:has(h1) ~ span a').map{|a| a.text}
    end
    cuisines.shift if cuisines.first == 'Unclaimed'

    main_cuisine = ([main_cuisine] + cuisines).compact.first

    unless unwanted_cuisines.include?(main_cuisine)
      cuisines = []
      html.search('script[type="application/ld+json"]').each do |js|
        cs_json = JSON.parse(js)
        if cs_json.include? "itemListElement"
          cuisines << cs_json['itemListElement'][1]['item']['name'].gsub("amp;", '') rescue nil
        end
      end
      # cuisines = ([main_cuisine] + cuisines).compact - not_cuisines rescue []
      main_cuisine = cuisines.first

      if rating.nil?
        rating = html.at('div.photoHeader__373c0__1lZx8 div.i-stars__373c0___sZu0')['aria-label'][/([\d\.]+) star/, 1].to_f rescue nil
        rating ||= html.at('div.arrange-unit__373c0__3S8rT.arrange-unit-fill__373c0__24Gfj div.i-stars__373c0___sZu0')['aria-label'][/([\d\.]+) star/, 1].to_f rescue nil
        reviews_count = html.at('div.photoHeader__373c0__1lZx8 span.css-bq71j2:contains("review")').text[/(\d+) review/, 1].to_i rescue nil
        reviews_count ||= html.at('div.arrange-unit__373c0__3S8rT.arrange-unit-fill__373c0__24Gfj span.css-1h1j0y3:contains("review")').text[/(\d+) review/, 1].to_i rescue nil
      end

      lat, long = html.at('a.biz-map-directions img[alt="Map"]')['src'].scan(/center=([\-\.\d]+)%2C([\-\.\d]+)&/).first rescue [nil, nil]
      lat, long = html.at('section:contains("Location") img[alt="Map"]')['src'].scan(/center=([\-\.\d]+)%2C([\-\.\d]+)&/).first rescue [nil, nil] if lat.nil?

      # hours = html.search('table.table.table-simple.hours-table tr:has(th)').inject({}) do |a,b|
        # value = b.at('td').inner_html.split('<br>').map do |range|
      # hours = html.search('table.table--simple__373c0__3lyDA.hours-table__373c0__1S9Q_ tr:has(th)').inject({}) do |a,b|
      # hours = html.search('table.table--simple__09f24__3lyDA.hours-table__09f24__1S9Q_ tr:has(th)').inject({}) do |a,b|
      # hours = html.search('table.table--simple__373c0__3hEOO.hours-table__373c0__1S9Q_ tr:has(th)').inject({}) do |a,b|
      # hours = html.search('table.table--simple__373c0__3QsR_.hours-table__373c0__2YHlD tr:has(th)').inject({}) do |a,b|
      #   key = b.at('th').text[0..2]
      #   value = b.search('td ul li p').map(&:text).map do |range|
      #     if range =~ /24 hours/i
      #       '0000-0000'
      #     else
      #       range.split('-').map do |d|
      #         time = Time.parse(Nokogiri::HTML(d.strip).text).strftime("%H%M")
      #       end.join('-')
      #     end
      #   end rescue nil
      #   a.merge({key => value})
      # end.delete_if{|a,b| b.nil? || b.empty?}
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
        hours = html.search('table.table--simple__09f24__vy16f.hours-table__09f24__KR8wh tr:has(th)').inject({}) do |a,b|
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

      tags = html.to_html.scan(/0\.properties\.\d+.+?displayText&quot;:&quot;(.+?)&quot;/).flatten
      delivery = tags.include?('Offers Delivery')

      location = {
        _collection: "locations_#{page['vars']['country'].downcase}",
        _id: uuid,
        date: Time.now.strftime('%Y%m%d %H:%M:%S'),
        lead_id: uuid,
        url: page['url'],
        restaurant_name: name,

        price_category: price_category,
        # average_rating: store[''],
        # delivery_time: "#{store['etaRange']['min']} - #{store['etaRange']['max']} min",
        # total_number_of_ratings: store[''],
        # does_delivery_not: store[''],
        restaurant_address: street_1,
        restaurant_address1: street_1,
        # restaurant_address2: street_2,
        restaurant_city: city,
        restaurant_area: state,
        restaurant_post_code: zip,
        restaurant_country: country,
        restaurant_lat: lat,
        restaurant_long: long,
        phone_number: phone,
        restaurant_delivers: delivery,
        # restaurant_overall_rating: (html.at('span.overallRating').text.strip rescue nil),
        restaurant_rating: rating,
        restaurant_position: nil,
        number_of_ratings: reviews_count,
        main_cuisine: main_cuisine,
        cuisine_name: cuisines,
        opening_hours: hours,
        restaurant_tags: tags,
        restaurant_deivery_zones: [],
        free_field: {
          # website: (html.at('div:has(p:contains("Business website")) a').text.strip rescue nil)
          website: (html.search('div:has(p:contains("Business website"))').last.text.match(/http:.*\.com/) rescue nil)
        }
      }
      outputs << location

      html.search('section:contains("People Also Viewed") a[href]').map{|a| a['href']}.each do |related|
        pages << {
          url: "https://www.yelp.com#{related}",
          page_type: 'restaurant',
          fetch_type: "browser",
          headers: {
            "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36",
            "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
          },
          http2: true,
          vars: {
            country: page['vars']['country'],
            position: (0)
          }
        }
      end
    end
  end
end
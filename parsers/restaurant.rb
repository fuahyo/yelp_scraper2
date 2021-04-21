parsable = true

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

if page['failed_response_status_code']
  puts 'refetch restaurant'
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

  if rating.nil?
    rating = html.at('div.photoHeader__373c0__YdvQE div.i-stars__373c0__1T6rz')['aria-label'][/([\d\.]+) star/, 1].to_f rescue nil
    reviews_count = html.at('div.photoHeader__373c0__YdvQE span.css-bq71j2:contains("review")').text[/(\d+) review/, 1].to_i rescue nil
  end

  lat, long = html.at('a.biz-map-directions img[alt="Map"]')['src'].scan(/center=([\-\.\d]+)%2C([\-\.\d]+)&/).first rescue [nil, nil]
  lat, long = html.at('section:contains("Location") img[alt="Map"]')['src'].scan(/center=([\-\.\d]+)%2C([\-\.\d]+)&/).first rescue [nil, nil] if lat.nil?

  cuisines = html.search('span.category-str-list a').map{|cat| cat.text.strip.gsub(/\\u([a-f0-9]{4,5})/i){ [$1.hex].pack('U') }}.uniq rescue []

  if cuisines == nil || cuisines.count == 0
    cuisines = html.search('div:has(h1) ~ span a').map{|a| a.text}
  end
  cuisines.shift if cuisines.first == 'Unclaimed'

  main_cuisine = ([main_cuisine] + cuisines).compact.first

  # hours = html.search('table.table.table-simple.hours-table tr:has(th)').inject({}) do |a,b|
    # value = b.at('td').inner_html.split('<br>').map do |range|
  # hours = html.search('table.table--simple__373c0__3lyDA.hours-table__373c0__1S9Q_ tr:has(th)').inject({}) do |a,b|
  # hours = html.search('table.table--simple__09f24__3lyDA.hours-table__09f24__1S9Q_ tr:has(th)').inject({}) do |a,b|
  hours = html.search('table.table--simple__373c0__3hEOO.hours-table__373c0__1S9Q_ tr:has(th)').inject({}) do |a,b|
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
    # restaurant_address: (store['location']['address']['formattedAddress'].present? ? store['location']['address']['formattedAddress'] : ['address1', 'city', 'country'].map{ |f| store['location']['address'][f] }.compact.join(', ')),
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
    restaurant_position: page['vars']['position'],
    number_of_ratings: reviews_count,
    main_cuisine: main_cuisine,
    cuisine_name: cuisines,
    opening_hours: hours,
    restaurant_tags: tags,
    restaurant_deivery_zones: [],
    free_field: {
      website: (html.at('span.biz-website a').text.strip rescue nil)
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

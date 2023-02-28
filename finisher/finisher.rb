per_page = 500
last_id = ''
locations = []

while true
  query = {
    '_id' => {'$gt' => last_id},
    '$orderby' => [{'_id' => 1}]
  }
  records = find_outputs("locations", query, 1, per_page)

  records.each do |location|
    cuisines = {}
    location['cuisine_name'].each_with_index do |cuisine, index|
        cuisines["cuisine#{index + 1}"] = cuisine
    end rescue {}
    
    unless location['main_cuisine'].nil?
      if location['main_cuisine'].include?(',')
        main_cuisine = location['main_cuisine'].split(',').first
        location['main_cuisine'] = main_cuisine
      end
    end

    if location['main_cuisine'] == "Restaurants"
      cuisines["cuisine1"] = "Restaurant"
    end

    location['restaurant_post_code'] = nil if location['restaurant_post_code'].nil? || location['restaurant_post_code'].empty?
    location['cuisine_name'] = cuisines

    outputs << location

    save_outputs(outputs) if outputs.count > 99
  end

  break if records.nil? || records.count < 1

  last_id = records.last['_id']
end
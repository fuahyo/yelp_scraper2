country_code = ENV['country_code']

per_page = 500
last_id = ''
locations = []

while true
  query = {
    '_id' => {'$gt' => last_id},
    '$orderby' => [{'_id' => 1}]
  }
  records = find_outputs("locations_#{country_code.downcase}", query, 1, per_page)
  records2 = find_outputs("locations", query, 1, per_page)

  records.each do |location|
    # location['free_field'] = {}
    cuisines = {}
    location['cuisine_name'].each_with_index do |cuisine, index|
        cuisines["cuisine#{index + 1}"] = cuisine
    end rescue {}
    
    location['cuisine_name'] = cuisines
    outputs << location

    save_outputs(outputs) if outputs.count > 99
  end

  records2.each do |location|
    # location['free_field'] = {}
    cuisines = {}
    location['cuisine_name'].each_with_index do |cuisine, index|
        cuisines["cuisine#{index + 1}"] = cuisine
    end rescue {}
    
    location['cuisine_name'] = cuisines
    outputs << location

    # save_outputs(outputs) if outputs.count > 99
  end

  break if records.nil? || records.count < 1

  last_id = records.last['_id']
  
#   locations.push(*records)
#   puts "locations: #{locations.count}"
end
seed_data = {
  'CL' => {
    sw_corner: {lat: -55.61183, long: -75.6443953112},
    ne_corner: {lat: -17.5800118954, long: -66.95992}
  },
  'CZ' => {
    sw_corner: {lat: 48.5553052842, long: 12.2401111182},
    ne_corner: {lat: 51.1172677679, long: 18.8531441586}
  }
}

seed_data.each do |code, coords|
  (coords[:sw_corner][:lat].floor..coords[:ne_corner][:lat].ceil).each do |lat|
    (coords[:sw_corner][:long].floor..coords[:ne_corner][:long].ceil).each do |long|
      pages << {
        url: "https://www.yelp.com/search/snippet?cflt=restaurants&l=g:#{long.to_f},#{lat.to_f},#{long.to_f-1},#{lat.to_f-1}&start=0",
        page_type: 'locations',
        headers: {
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",
          "Accept" => "*/*"
        },
        http2: true,
        vars: {
          country: code,
          initial: true
        }
      }
    end
  end
end

seed_data = {
  'CL' => {#    'CL': ('Chile', (-75.6443953112, -55.61183, -66.95992, -17.5800118954)),
    sw_corner: {lat: -55.61183, long: -75.6443953112},
    ne_corner: {lat: -17.5800118954, long: -66.95992}
  },
  'CZ' => {#    'CZ': ('Czech Rep.', (12.2401111182, 48.5553052842, 18.8531441586, 51.1172677679)),
    sw_corner: {lat: 48.5553052842, long: 12.2401111182},
    ne_corner: {lat: 51.1172677679, long: 18.8531441586}
  },
  'CA' => {#    'CA': ('Canada', (-140.99778, 41.6751050889, -52.6480987209, 83.23324)),
    sw_corner: {lat: 41.6751050889, long: -140.99778},
    ne_corner: {lat: 83.23324, long: -52.6480987209}
  },
  'SE' => {#    'SE': ('Sweden', (11.0273686052, 55.3617373725, 23.9033785336, 69.1062472602)),
    sw_corner: {lat: 55.3617373725, long: 11.0273686052},
    ne_corner: {lat: 69.1062472602, long: 23.9033785336}
  },
  'AR' => {#    'AR': ('Argentina', (-73.4154357571, -55.25, -53.628348965, -21.8323104794)),
    sw_corner: {lat: -55.25, long: -73.4154357571},
    ne_corner: {lat: -21.8323104794, long: -53.628348965}
  },
  'AT' => {#    'AT': ('Austria', (9.47996951665, 46.4318173285, 16.9796667823, 49.0390742051)),
    sw_corner: {lat: 46.4318173285, long: 9.47996951665},
    ne_corner: {lat: 49.0390742051, long: 16.9796667823}
  },
  'FI' => {#    'FI': ('Finland', (20.6455928891, 59.846373196, 31.5160921567, 70.1641930203)),
    sw_corner: {lat: 59.846373196, long: 20.6455928891},
    ne_corner: {lat: 70.1641930203, long: 31.5160921567}
  },
  'NO' => {#    'NO': ('Norway', (4.99207807783, 58.0788841824, 31.29341841, 80.6571442736)),
    sw_corner: {lat: 58.0788841824, long: 4.99207807783},
    ne_corner: {lat: 80.6571442736, long: 31.29341841}
  }
}

seed_data.each do |code, coords|
  (coords[:sw_corner][:lat].floor..coords[:ne_corner][:lat].ceil).each do |lat|
    (coords[:sw_corner][:long].floor..coords[:ne_corner][:long].ceil).each do |long|
      # pages << {
      #   url: "https://www.yelp.com/search/snippet?cflt=restaurants&l=g:#{long.to_f},#{lat.to_f},#{long.to_f-1},#{lat.to_f-1}&start=0",
      #   page_type: 'locations',
      #   # fetch_type: "browser",
      #   headers: {
      #     "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36",
      #     "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
      #   },
      #   http2: true,
      #   vars: {
      #     country: code,
      #     initial: true
      #   }
      # }
      pages << {
        url: "https://www.yelp.com/search?start=0&cflt=restaurants&l=g:#{long.to_f},#{lat.to_f},#{long.to_f-1},#{lat.to_f-1}",
        page_type: 'seed',
        fetch_type: "browser",
        headers: {
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36",
          "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
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

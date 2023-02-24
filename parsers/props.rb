

json = JSON.parse(content)['bizDetailsPageProps'] 

related_restaurants = json['relatedBusinessesCarouselProps']['relatedBusinesses'] rescue nil

related_restaurants&.each do |rest|

    url = URI.parse('https://www.yelp.com' + rest['businessUrl'])
    url.fragment = nil
    url.query = nil
    url = url.to_s

    pages << {
        url: url,
        page_type: 'restaurant',
        fetch_type: "standard",
        headers: {
          "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.50",
          "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
        },
        http2: true,
        vars: {
          country: page['vars']['country'],
          position: 0,
          parent_gid: page['gid'],
        }
        save_pages(pages) if pages.count > 99
    }



end


if page['failed_response_status_code']
  puts 'refetch seed'
  refetch page['gid']
end
code = "
  await sleep(3000); 
"
parsable = true

json = JSON.parse(content)

if parsable

  total_results = json['searchPageProps']['mainContentComponentsListProps'].find{|x| x['type'] == "pagination" }['props']['totalResults'] rescue 0

  if total_results > 10 && page['vars']['initial']
    # pagination
    (10..total_results).step(10).each do |start|
      next if start == total_results
      link = page['url'].gsub('start=0', "start=#{start}")
      pages << {
        url: link,
        page_type: 'seed',
        vars: {
          country: page['vars']['country'],
        }
      }
      save_pages(pages) if pages.count > 99
    end
  end

  restaurants = json['searchPageProps']['mainContentComponentsListProps']&.filter{|x| !x['bizId'].nil?} rescue nil

  restaurants&.each_with_index do |item, idx|

    rest = item['searchResultBusiness']
    url = 'https://www.yelp.com' + rest['businessUrl']
    
    if url =~ /redirect_url/
      url = URI.decode(url.scan(/redirect_url=(http.+?)&/).first.first)
    end

    url = URI.parse(url)
    url.fragment = nil
    url.query = nil
    url = url.to_s

    pages << {
      url: url,
      page_type: 'restaurant',
      fetch_type: "standard",
      headers: {
        "User-Agent" => "Google-Extended",
        "Accept-Encoding" => "gzip, deflate, br",
        "Accept-Language" => "en-US,en;q=0.9",
        "Cache-Control" => "max-age=0",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
      },
      http2: true,
      vars: {
        country: page['vars']['country'],
        position: idx + 1
      }
    }
    save_pages(pages) if pages.count > 99
  end

end

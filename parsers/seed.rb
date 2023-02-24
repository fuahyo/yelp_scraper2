if page['failed_response_status_code']
  puts 'refetch seed'
  refetch page['gid']
end
code = "
  await sleep(3000); 
"
parsable = true

# 

# html = Nokogiri::HTML(content)
json = JSON.parse(content)

# parsable = !html.at('div.no-results')
# parsable = !html.at('p.lemon--p__373c0__3Qnnj.text__373c0__2pB8f.text-color--normal__373c0__K_MKN:contains("Suggestions for improving the results")')
# parsable = !html.at('p.css-znumc2:contains("Suggestions for improving the results")')

if parsable

  total_results = json['searchPageProps']['mainContentComponentsListProps'].find{|x| x['type'] == "pagination" }['props']['totalResults'] rescue 0

  # raise 'todo' if total_results > 0

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
        "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36 Edg/110.0.1587.50",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
      },
      http2: true,
      vars: {
        country: page['vars']['country'],
        position: idx + 1
      }
    } save_pages(pages) if pages.count > 99
  end

end

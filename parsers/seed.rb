if page['failed_response_status_code']
  puts 'refetch seed'
  refetch page['gid']
end

parsable = true

html = Nokogiri::HTML(content)

parsable = !html.at('div.no-results')
parsable = !html.at('p.lemon--p__373c0__3Qnnj.text__373c0__2pB8f.text-color--normal__373c0__K_MKN:contains("Suggestions for improving the results")')
parsable = !html.at('p.css-znumc2:contains("Suggestions for improving the results")')

if parsable

  if page['vars']['initial']
    last_page = html.at('div[aria-label="Pagination navigation"] span:contains("of")').text.scan(/1 of (\d+)/).first.first.to_i rescue 1
    (2..last_page).each do |page_num|
      link = page['url'].gsub('start=0', "start=#{page_num*30-30}")
      pages << {
        url: link,
        page_type: 'seed',
        # fetch_type: "browser",
        # http2: true,
        # "driver": {
        #   "code": "await sleep(3000);",
        #   "goto_options": {
        #     "waitUntil": "domcontentloaded"
        #   },
        #   enable_images: true,
        # },
        vars: {
          country: page['vars']['country'],
        }
      }
    end
  end

  html.search('li.border-color--default__09f24__NPAKY a:has(img)').each_with_index do |item, idx|
    uri = item['href']
    link = "https://www.yelp.com#{uri}"
    if link =~ /redirect_url/
      link = URI.decode(link.scan(/redirect_url=(http.+?)&/).first.first)
    end
    pages << {
      url: link,
      page_type: 'restaurant',
      # fetch_type: "browser",
      headers: {
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.116 Safari/537.36",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"
      },
      # driver: {
      #   name: "",
      #   enable_images: true,
      # },
      http2: true,
      vars: {
        country: page['vars']['country'],
        position: idx + 1
      }
    }
  end

end

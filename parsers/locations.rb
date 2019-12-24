if page['failed_response_status_code']
  puts 'refetch seed'
  refetch page['gid']
end

html = Nokogiri::HTML(content)

if html.at('div.no-results').blank?

  if page['vars']['country']
    last_page = html.at('div.page-of-pages').text.scan(/Page 1 of (\d+)/).first.first.to_i rescue 1
    (2..last_page).each do |page_num|
      link = url.gsub('start=0', "start=#{page_num*30-30}")
      pages << {
        url: link,
        page_type: 'locations',
        headers: {
          "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",
          "Accept" => "*/*"
        },
        http2: true,
        vars: {
          country: page['vars']['country'],
        }
      }
    end
  end
  # page.search('li.domtags--li__373c0__3TKyB.list-item__373c0__M7vhU h3:has(a)').each do |item|
  # page.search('li.lemon--li__373c0__1r9wz.border-color--default__373c0__2oFDT h3:has(p)').each do |item|
  html.search('li.lemon--li__373c0__1r9wz.border-color--default__373c0__2oFDT a:has(img).lemon--a__373c0__IEZFH').each do |item|
    uri = item['href']
    pages << {
      url: "https://www.yelp.com#{uri}",
      page_type: 'restaurant',
      headers: {
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",
        "Accept" => "*/*"
      },
      http2: true,
      vars: {
        country: page['vars']['country'],
        position: (item.at('text()').text().to_i rescue 0)
      }
    }
  end
end

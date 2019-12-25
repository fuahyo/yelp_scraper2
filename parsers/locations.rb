if page['failed_response_status_code']
  puts 'refetch seed'
  refetch page['gid']
end

# html = Nokogiri::HTML(content)
json = JSON.parse(content) rescue nil

unless json['searchPageProps']['searchResultsProps']['searchResults'].nil?

  if page['vars']['initial']
    last_page = (json['searchPageProps']['headerProps']['pagerData']['total']/30.0).ceil rescue 1
    (2..last_page).each do |page_num|
      link = page['url'].gsub('start=0', "start=#{page_num*30-30}")
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
  json['searchPageProps']['searchResultsProps']['searchResults'].select{|a| !(a['searchResultBusiness'].nil?)}.each do |item|
    link = item['searchResultBusiness']['businessUrl']
    pages << {
      url: "https://www.yelp.com#{link}",
      page_type: 'restaurant',
      headers: {
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_3) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/78.0.3904.97 Safari/537.36",
        "Accept" => "*/*"
      },
      http2: true,
      vars: {
        country: page['vars']['country'],
        position: (item['markerKey'] rescue 0)
      }
    }
  end

end

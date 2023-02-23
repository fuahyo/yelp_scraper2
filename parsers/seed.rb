if page['failed_response_status_code']
  puts 'refetch seed'
  refetch page['gid']
end
code = "
  await sleep(3000); 
"
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
      fetch_type: "browser",
      cookie: "_schn=_ip1vhr; qntcst=D; bse=6a10749ab5184070875507b4cb3fce31; hl=en_US; wdi=2|431B6CF52255CC78|0x1.8fde442dc7925p+30|84d51ed00f21744b; _gcl_au=1.1.1738794142.1677168909; _fbp=fb.1.1677168909784.1817083256; _scid=ace4c237-4d82-46d5-bb70-47b1bb1c04de; _tt_enable_cookie=1; _ttp=l_8pvVw1yhjVSjHWIXrI1npT5ks; _ga=GA1.2.431B6CF52255CC78; _gid=GA1.2.1800410801.1677168913; __qca=P0-723946894-1677168914303; _sctr=1|1677085200000; xcj=1|xfSwvF_F9LPpfDMgCxUKXwKcwkKHl1WpsDYKNpqzYZU; OptanonConsent=isGpcEnabled=0&datestamp=Thu+Feb+23+2023+23%3A19%3A55+GMT%2B0700+(Western+Indonesia+Time)&version=6.34.0&isIABGlobal=false&hosts=&consentId=dcdb6586-77bc-442e-95f2-f039db532dd7&interactionCount=0&landingPath=https%3A%2F%2Fwww.yelp.com%2Fbiz%2Fhladov%25C3%25A1-nota-pec-pod-sn%25C4%259B%25C5%25BEkou&groups=BG51%3A1%2CC0003%3A1%2CC0002%3A1%2CC0001%3A1%2CC0004%3A1; _uetsid=4066e050b39511edb119e91d3b1dcad1; _uetvid=4066f640b39511eda256effcb89e8aa7; _ga_K9Z2ZEVC8C=GS1.2.1677168913.1.1.1677169195.0.0.0",
      headers: {
        "User-Agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
        "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
      },
      driver: {
        "code" => code,
        "goto_options" => {
          "waitUntil": "domcontentloaded"
        }
      },
      # http2: true,
      vars: {
        country: page['vars']['country'],
        position: idx + 1
      }
    }
  end

end

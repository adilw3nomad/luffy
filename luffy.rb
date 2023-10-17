require 'httpx'

module Luffy
  def webpage_to_s(chap_url)
    HTTPX.get(chap_url).to_s
  end

  def imageurls_from_webpage(page)
    image_urls = []
    page.scan(/<img class="pages__img" src="(.*?)"/) do |match|
        url = match[0].strip
        url.delete! "\r" # Remove any newlines
        image_urls << url
    end
    image_urls
  end


  def fetch_and_store(image_urls)
    image_urls.each_with_index do |url, i|
      puts "fetching image #{url}"
        
      File.open("#{i}.jpeg", 'ab') do |file| 
            response = HTTPX.get(url)
            file << response.read
      end
    end  
  end
end
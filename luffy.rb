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
      response = HTTPX.get(url)
      jpeg_content = response.body.read
      footer_index = jpeg_content.match(/\xFF\xD9\z/).begin(0)
      binding.irb
    
      File.open("test.jpeg", 'ab') do |file|
      file << jpeg_content
      end
    end  
  end
end
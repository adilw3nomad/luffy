#!/usr/bin/env ruby

require 'httpx'

chap_url = ARGV[0]
file_name = ARGV[1]


page = HTTPX.get(chap_url).to_s

image_urls = []
page.scan(/<img class="pages__img" src="(.*?)"/) do |match|
    url = match[0].strip
    url.delete! "\r" # Remove any newlines
    image_urls << url
end



image_urls.each_with_index do |url, i|
    puts "fetching image #{url}"
    
    File.open("#{i}.jpeg", 'ab') do |file| 
        response = HTTPX.get(url)
        file << response.read
    end
end  

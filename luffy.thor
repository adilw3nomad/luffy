require './luffy.rb'

class Luffycli < Thor
  include Luffy

  desc "chapter", "scrapes a manga chapter webpage and downloads each image in order"
  def chapter(chapter_url)
    images = imageurls_from_webpage(webpage_to_s(chapter_url))
    fetch_and_store(images)
  end
end
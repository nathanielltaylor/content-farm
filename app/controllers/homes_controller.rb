require 'open-uri'

class HomesController < ApplicationController
  def index
    page = Nokogiri::HTML(open("https://www.buzzfeed.com", :allow_redirections => :all))
    titles = page.at('div.col1').inner_text.squish.gsub(/[\n\t]/, "")
    titles = titles.gsub(/(([0-9]*|a few|an|a|a half) (minutes|hours|minute|hour) ago [0-9]* (responses|response))|Promoted by BuzzFeed Staff Sponsored/, "BREAKPOINT")
    title_array = titles.split("BREAKPOINT")
    title_array.delete_if { |t| /var load_ad/ =~ t }.pop
    title_array.map! { |t| t.split[0...-2].join(" ") }
    binding.pry
    #implement persistence of titles and generate chains based on random sampling
    #later move all functionality of interacting with buzzfeed to background worker or rake task
    buzzfactory = MarkovChainGenerator.new(titles)
    buzzfactory.find_patterns
    @content = []
    10.times do
      @content << buzzfactory.generate_chain(12)
    end
  end
end

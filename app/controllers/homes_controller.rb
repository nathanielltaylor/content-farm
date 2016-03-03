require 'open-uri'

class HomesController < ApplicationController
  def index
    page = Nokogiri::HTML(open("https://www.buzzfeed.com", :allow_redirections => :all))
    titles = page.at('div.col1').inner_text.gsub(/[\n\t]/, "").squish
    buzzfactory = MarkovChainGenerator.new(titles)
    buzzfactory.find_patterns
    @content = []
    10.times do
      @content << buzzfactory.generate_chain(12)
    end
  end
end

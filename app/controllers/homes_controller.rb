require 'open-uri'

class HomesController < ApplicationController
  def index
    page = Nokogiri::HTML(open("https://www.buzzfeed.com", :allow_redirections => :all))
    titles = page.at('div.col1').inner_text.squish.gsub(/[\n\t]/, "").gsub("var load_ad = true && (AD_DESIGN == 'gpt'); if( typeof acl != 'undefined' ) load_ad &= !acl.user_can('edit_hidden_ads'); if (load_ad) { loadGPTAd({ wid: ", "")
    binding.pry
    buzzfactory = MarkovChainGenerator.new(titles)
    buzzfactory.find_patterns
    @content = []
    10.times do
      @content << buzzfactory.generate_chain(12)
    end
  end
end

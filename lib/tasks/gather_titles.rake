require 'open-uri'

namespace :gather_titles do
  desc "BUZZFEED"
    task :get_bf_titles => :environment do
      page = Nokogiri::HTML(open("https://www.buzzfeed.com", :allow_redirections => :all))
      titles = page.at('div.col1').inner_text.squish.gsub(/[\n\t]/, "")
      titles = titles.gsub(/(([0-9]*|a few|an|a|a half) (minutes|hours|minute|hour) ago [0-9]* (responses|response))|Promoted by BuzzFeed Staff Sponsored/, "BREAKPOINT")
      title_array = titles.split("BREAKPOINT")
      title_array.delete_if { |t| /var load_ad/ =~ t }.pop
      title_array.each do |t|
        t = t.split[0...-2].join(" ")
        Title.create(title: t)
      end
    end
end
#this needs to be scheduled to happen regularly

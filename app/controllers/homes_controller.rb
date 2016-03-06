class HomesController < ApplicationController
  def index
    title_array = Title.all
    titles = ""
    title_array.each { |title| titles += title.title }
    buzzfactory = MarkovChainGenerator.new(titles)
    buzzfactory.find_patterns
    @content = []
    10.times do
      @content << buzzfactory.generate_chain(12)
    end
  end
end

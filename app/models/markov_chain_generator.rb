class MarkovChainGenerator
  attr_accessor :text, :words, :frequencies, :sequenced

  def initialize(text)
    @text = text
    @words = text.split
    @frequencies = {}
    @sequenced = false
  end

  def find_patterns
    @words.each_with_index do |word, index|
      if index < (@words.length - 1)
        if !@frequencies.include?(word)
          @frequencies[word] = {}
          @frequencies[word][@words[index + 1]] = 1
        elsif !@frequencies[word].include?(@words[index + 1])
          @frequencies[word][@words[index + 1]] = 1
        else
          @frequencies[word][@words[index + 1]] += 1
        end
      end
    end
    @sequenced = true
  end

  def generate_chain(word_count, start = nil)
    warning_a = "Please run the instance method 'find_patterns' first to build the dictionary."
    warning_b = "The start word that you have provided does not appear in the text used to build this generator."
    chain = ""
    return warning_a if @sequenced == false
    start = @words.sample if start == nil
    return warning_b if !@words.include?(start)
    chain += start
    word_count.times do
      chain += " "
      probabilities = @frequencies[start]
      next_word = weighted_choice(probabilities)
      chain += next_word
      start = next_word
    end
    chain
  end

  def weighted_choice(hash)
    total = hash.inject(0) { |sum, item_and_weight| sum += item_and_weight[1] }
    target = rand(total)
    hash.each do |item, weight|
      return item if target <= weight
      target -= weight
    end
  end
end

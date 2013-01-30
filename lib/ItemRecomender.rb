#encoding: utf-8
require 'StemmerPTBR'
class ItemRecomender

  def self.similar(item, max, lost)
    recomendeds = []
    stemmer = StemmerPTBR.new
    item_words = (item.description + " " + item.title).sub("\n", " ").delete("^[a-z\s-]").split(" ")
    item_comparable = item_words.join(" ")
    
    for x in Item.where(:lost => lost, :returned => false) do
      corpus = TfIdfSimilarity::Collection.new
      
      x_words = (x.description + " " + x.title).sub("\n", " ").delete("^[a-z\s-]").split(" ")
      x_comparable = x_words.join(" ")
      
      corpus << TfIdfSimilarity::Document.new(item_comparable)
      corpus << TfIdfSimilarity::Document.new(x_comparable)
      puts item_comparable
      puts x_comparable
      puts corpus.similarity_matrix[1]
      
      if corpus.similarity_matrix[1] > 0.32
        recomendeds.push x unless x == item || recomendeds.size > max
      end      
    end
  
    return recomendeds
  end 
end

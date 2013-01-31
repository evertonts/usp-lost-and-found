#encoding: utf-8
require 'StemmerPTBR'
class ItemRecomender

  def self.similar(item, max, lost)
    recomendeds = []
    stemmer = StemmerPTBR.new

    item_title = normalize(item.title, stemmer)
    item_description = normalize(item.description, stemmer)
    
    for x in Item.where(:lost => lost, :returned => false) do
      title = TfIdfSimilarity::Collection.new
      
      x_title = normalize(x.title, stemmer)
      
      title << TfIdfSimilarity::Document.new(item_title)
      title << TfIdfSimilarity::Document.new(x_title)
      
      puts "TITLE: " + item_title + " - " + x_title
      puts title.similarity_matrix[1]
      
      if title.similarity_matrix[1] > 0.32
        recomendeds.push x unless x == item || recomendeds.size > max
      else
        description = TfIdfSimilarity::Collection.new
        
        x_description = normalize(x.description, stemmer)
        
        description << TfIdfSimilarity::Document.new(item_description)
        description << TfIdfSimilarity::Document.new(x_description)

        puts "DESCRICAO: " + item_description + " - " + x_description
        puts description.similarity_matrix[1]
        if description.similarity_matrix[1] > 0.25
          recomendeds.push x unless x == item || recomendeds.size > max
        end
      end
    end
    
    return recomendeds
  end
  
  private 
  
  def self.normalize(text, stemmer)
    tokens = []
    words = text.sub("\n", " ").delete("^[a-z\s-]").split(" ")
    for word in words
      tokens.push(stemmer.stem(word))
    end
    normalized = tokens.join(" ")
    normalized
  end
  
  def self.compare(a, b)
    
  end  
end

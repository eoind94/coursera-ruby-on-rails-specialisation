#Implement all parts of this assignment within (this) module2_assignment2.rb file

# Class called LineAnalyzer.
class LineAnalyzer
  # Read-only attributes in the LineAnalyzer class.
  attr_reader:highest_wf_count,  # a number with maximum number of occurrences for a single word (calculated)
             :highest_wf_words,  # an array of words with the maximum number of occurrences (calculated)
             :content,           # the string analyzed (provided)
             :line_number        # the line number analyzed (provided)

  $filename = 'test.txt'
  
  # Methods in the LineAnalyzer class.
  def initialize(content, line_number)  
    # taking a line of text (content) and a line number
    @content = content
    @line_number = line_number
    @highest_wf_words = Array.new
    $highest_wf_count = 0

    calculate_word_frequency     # call the calculate_word_frequency() method.
  end
 
  def calculate_word_frequency()  # calculates result
    wordFreq = Hash.new(0)
    content.split(' ').each do |word|
      wordFreq[word.downcase] += 1
    end

    self.highest_wf_count = wordFreq.values.sort.reverse.first

    wordFreq.each_pair do |key, value|
      self.highest_wf_words.push(key) if highest_wf_count == value
    end

    #freq = @@content.inject(Hash.new(0)) { |h,v| h[v] += 1; h}     
    #@@highest_wf_words = freq.sort_by {|key, value| value}.reverse.to_h
    #@@highest_wf_count = @@highest_wf_words.values[0]

  end

end   # end of LineAnalyzer class

# Class called Solution. 
class Solution
  # Read-only attributes in the Solution class.
  attr_reader:analyzers,                            # an array of LineAnalyzer objects for each line in the file
             :highest_count_across_lines,           # a number with the maximum value for highest_wf_words attribute in the analyzers array.
             :highest_count_words_across_lines      # a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
                                                    # equal to the highest_count_across_lines determined previously.
  # Methods in the Solution class.
  def initialize()
    @analyzers = Array.new     # initialise analyzers as an empty array
  end  
  
  def analyze_file() # processes 'test.txt' intro an array of LineAnalyzers and stores them in analyzers.
    line_count = 1
    File.foreach($filename) do |line|      #* Read the 'test.txt' file in lines
        analyzers.push(LineAnalyzer.new(line, line_count))
        line_count += 1  
    end
  end

  def calculate_line_with_highest_frequency() # determines the highest_count_across_lines and highest_count_words_across_lines attribute values
    @highest_count_across_lines = analyzers.sort_by{ |analyzer| analyzer.highest_wf_count }.reverse.first.highest_wf_count
    @highest_count_words_across_lines = analyzers.select{ |analyzer| @highest_count_across_lines == analyzer.highest_wf_count  }
    #i = 0
    #while i < @@analyzers.length()
      #count = @@analyzers[i].split(/[^-a-zA-Z]/).size
      #if count > @@highest_count_words_across_lines
        #@@highest_count_words_across_lines = count
      #else
        #i += 1
      #end
    #end
    #puts "\nThe hightest word count across the lines of the .txt file is #{@@highest_count_words_across_lines}"
    #words on line #{@@line_count}.\n"

  #* calculate the maximum value for highest_wf_count contained by the LineAnalyzer objects in analyzers array
  #  and stores this result in the highest_count_across_lines attribute.
  #* identifies the LineAnalyzer objects in the analyzers array that have highest_wf_count equal to highest_count_across_lines 
  #  attribute value determined previously and stores them in highest_count_words_across_lines.
  end

  def print_highest_word_frequency_across_lines() # prints the values of LineAnalyzer objects in highest_count_words_across_lines in the specified format
    @highest_count_words_across_lines.each do |analyzer| 
      puts "#{analyzer.highest_wf_words} (appears in line #{analyzer.line_number})"
    end
    #LineAnalyzer.new
    #puts "The following words have the highest word frequency per line:"
    #puts "#{$highest_wf_words} (appears in line #{@@line_number})" 
  end

end   # end of Solution class
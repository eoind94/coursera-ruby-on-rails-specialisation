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
  	def initialize(content, line_number)  # taking a line of text (content) and a line number
    	@content = content
    	@line_number = line_number
    	@highest_wf_words = Array.new
   		@highest_wf_count = 0

    	calculate_word_frequency     # call the calculate_word_frequency() method.
  	end # end of initialize method
	
	def calculate_word_frequency()
	
		freq=Hash.new(0) # create a new empty hash map
		content.split(' ').each do |word| # split text up and assign each word to a key
      		freq[word.downcase] += 1 # calculate frequency of each word
      	end
		
		# go throught the hash map and get the word with highest frequency and record highest word frequency count
		count=0
		freq.each{|key,value| count=value if value>count }
		@highest_wf_count=count
		freq.each{|key,value| @highest_wf_words.push(key.to_s) if value.to_i==@highest_wf_count}
	end # end of calculate_word_frequency method
end # end of LineAnalyzer class

# class called Solution
class Solution
	 # Read-only attributes in the Solution class.
	attr_reader:analyzers,                            # an array of LineAnalyzer objects for each line in the file
               :highest_count_across_lines,           # a number with the maximum value for highest_wf_words attribute in the analyzers array.
               :highest_count_words_across_lines      # a filtered array of LineAnalyzer objects with the highest_wf_words attribute 
                                                      # equal to the highest_count_across_lines determined previously.
  # Methods in the Solution class.
	def initialize()
    	@analyzers = Array.new     # initialise analyzers as an empty array
    	@highest_count_words_across_lines = Array.new
  	end  # end of initialize method
	
	def analyze_file()
		line_count = 1
    	File.foreach($filename) do |line|      # read the 'test.txt' file in lines
        	@analyzers.push(LineAnalyzer.new(line, line_count))
        	line_count += 1
        end
	end # end of analyze_file method
	
	def calculate_line_with_highest_frequency()
		max_count = 0
		@analyzers.each do |word|
			max_count = word.highest_wf_count if word.highest_wf_count > max_count 
		end
		@highest_count_across_lines = max_count
		
		@analyzers.each do |word|
		@highest_count_words_across_lines << word if word.highest_wf_count == @highest_count_across_lines
		end
	end # end of calculate_line_with_highest_frequency method
	
	def print_highest_word_frequency_across_lines()
	  puts "The following words have the highest word frequency per line:"
	  @highest_count_words_across_lines.each do |x|
			puts "#{x.highest_wf_words.inspect} (appears in line #{x.line_number})"  
	  end
	end # end of print_highest_word_frequency_across_lines method
end  # end of Solution class
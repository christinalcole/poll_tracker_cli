require 'pry'
require 'nokogiri'
require 'open-uri'


class PollTracker::Scraper  

  def call

    candidate_list
  end  

  def self.get_page      
    doc = Nokogiri::HTML(open("http://elections.huffingtonpost.com/pollster/2016-general-election-trump-vs-clinton"))  
  end

  def self.candidate_list_w_spead
    @candidates = get_page.css("div.scrollable-poll-table table#poll-table tr th.choice").text.split(/([[:upper:]][[:lower:]]*)/).delete_if(&:empty?)
    @candidates = @candidates.insert(0, @candidates.delete_at(1))
    @candidates
    @spread = get_page.css("div.scrollable-poll-table table#poll-table tr th.spread").text
    @candidates << @spread
  end

  def self.avg_results_hash
    @results = []
    @final_results = {}
    @clinton = get_page.css("ul#chart-choice-select li label.checked span.value").first.text.gsub("%", "").to_f
    @results << @clinton
    @trump = get_page.css("ul#chart-choice-select li label.checked span.value").last.text.gsub("%", "").to_f
    @results << @trump
    @results[0].to_i
    @results[1].to_i
    @results 
    @final_results[:clinton] = @results.first
    @final_results[:trump] = @results.last
    @final_results    
  end 

   def self.result_helper
    polls = []
    names = get_page.css("div.scrollable-poll-table table#poll-table td.choice") 
    names
  end  

  def self.all_poll_results
    results = []
    result_helper.each do |el|
      results << el.text
      results
    end
    results.first(100)
  end    


  def self.poll_names
    polls = []
    names = get_page.css("div.scrollable-poll-table table#poll-table tbody td.poll div.pollster a")
    names.children.collect do |name|
      polls << name.text
    end
    polls.first(25) 
  end

  def self.poll_names_w_numbers
    names = []
    poll_names.each.with_index(1) do |name, i|
       names << "#{i}. " "#{name}"
    end
    names
  end

  def self.poll_date
    @date_array = []
    @date = get_page.css("tr.poll-single-subpopulation div.dates")
    @date.children.each do |dates|
      @date_array << dates.text
    end
    @date_array.first(25)
  end


  def self.likely_voters
    @vote_array = []
    @voters = get_page.css("tr.poll-single-subpopulation div.npop")
    @voters.children.each do |vote|
      @vote_array << vote.text
    end
    @vote_array.first(25)
  end
 
end  

  

  # def self.results
  #   "#{list_polls}"
    

  # end  

  # def self.list_polls
  #   polls = []
  #   names = get_page.css("div.scrollable-poll-table table#poll-table td.choice")#.each {|link| link['data-label'] == "trump"}
  #   names 
  #   names.children.collect do |name|
  #     polls << name.text
  #   end
  # end  


  #   polls = []
  #   names = get_page.css("div.scrollable-poll-table table#poll-table tbody td.poll div.pollster a")
  #   names.children.collect do |name|
  #     polls << name.text
  #   end
  # end  

  # def self.list_top_polls

  #   polls_array = []
  #   list_polls.flatten.first(25).each.with_index(1) do |poll, i|
  #     polls_array <<  "#{i}. " "#{poll}"
  #   end
  #   polls_array
  # each_with_index                                             

  


  # def self.results
  #   #@clinton = get_page.css("ul#chart-choice-select li label.checked span.value").first.text.gsub("%", "").to_f
  #   #@trump = get_page.css("ul#chart-choice-select li label.checked span.value").last.text.gsub("%", "").to_f
  #   @trump = get_page.css("div.scrollable-poll-table table#poll-table td.choice")
  # end    

  

# names.children.collect do |name|
#       polls << name.text

  # def self.list_poll_results
  #   polls = []
  #   names = get_page.css("div.scrollable-poll-table table#poll-table td.choice").each {|link| link['data-label'] == "trump"}
  #   names.each.with_index(1) do |num|
  #     binding.pry
  #     polls << num.text 
  #   end
  #   polls
  # end


#div.scrollable-poll-table table#poll-table tbody td.poll div.pollster a


    #   def self.get_page 
#     doc = Nokogiri::HTML(open("http://elections.huffingtonpost.com/pollster/2016-general-election-trump-vs-clinton"))  
#   end

  # def self.poll_names
  #   polls = []
  #   names = get_page.css("div.scrollable-poll-table table#poll-table tbody td.poll div.pollster a")
  #   names.children.collect do |name|
  #     polls << name.text
  #   end
  #   polls
  # end

#   def create_from_name(poll_names) 
#     polls = []
#     poll_names.each do |name|
#       poll = Poll.new(name)
#       polls << poll 
#     end
#     polls
#   end



# end      

    # @res = Nokogiri::HTML(open("http://www.nytimes.com/interactive/2016/us/elections/polls.html?_r=1"))


    # @undecided = get_page.css("div#pollster-polls div.scrollable-poll-table tbody tr.poll-single-subpopulation td.choice")





  # def self.create_by_page 
      
  #   results = get_page.css("div.scrollable-poll-table table#poll-table tr th.choice")
  #   binding.pry
  # end




  # def self.create_new_poll

  # end











# Huffpost model - poll of polls - 326 pols from 42 pollsters
  # Clinton name - doc.css("ul#chart-choice-select li label.checked span.choice").first.text
  # Clinton number - doc.css("ul#chart-choice-select li label.checked span.value").first.text.gsub("%", "").to_f
  # Trump name - doc.css("ul#chart-choice-select li label.checked span.choice").last.text
  # Trump number - doc.css("ul#chart-choice-select li label.checked span.value").last.text.gsub("%", "").to_f     

  # Polls
  # candidates names(including "other", "undecided" and "spread") iterate w/ #each
  # doc.css("div#pollster-polls div.scrollable-poll-table table#poll-table").first
  
  # doc.css("div.scrollable-poll-table table#poll-table tr th.choice").each_with_index do |cand, i|
  #    puts "#{i+1}. #{cand.text}"
  # end
  # STDOUT the following
  # 1. Trump
  # 2. Clinton
  # 3. Other
  # 4. Undecided 

  #candidates = doc.css("div.scrollable-poll-table table#poll-table tr th.choice").text.split(/([[:upper:]][[:lower:]]*)/).delete_if(&:empty?)
  # this will return the following array:
  # ["Trump", "Clinton", "Other", "Undecided"]

  # doc.css("div.scrollable-poll-table table#poll-table tr th.spread").text
  # returns the word 'Spread' number 5 on the list above

# attributes = [ (Attr:0x3fc6f125919c { name = "class", value = "choice " }),
#                (Attr:0x3fc6f1259188 { name = "data-label", value = "trump" }),
#                                       children = [ (Text "42")] })

  
  
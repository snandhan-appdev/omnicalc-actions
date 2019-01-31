class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = (@numbers.max - @numbers.min)

    # Median
    # ======

   list = @sorted_numbers
   count_n = list.count
   item_number = 0
   answer = 0
   numba1 = @sorted_numbers.at(count_n / 2 - 1)
   numba2 = @sorted_numbers.at(count_n / 2)
   
   if list.count % 2 == 1
     item_number = @numbers.count / 2
     answer = @sorted_numbers.at(item_number)
   else
     answer = (numba1 + numba2) / 2
   end
        
    @median = answer

    @sum = @numbers.sum

    @mean = (@numbers.sum / @numbers.count)

    # Variance
    # ========
    n = @numbers.count
    array = @numbers
    array = array.map{ |x| x - @mean }
    array = array.map{ |y| y**2}
    array_sum = array.sum
    var = array_sum / (n-1)
    
    @variance = var
    
    var = @variance.to_f
    sdev = @variance**(0.5)
    @standard_deviation = sdev

    # Mode
    # ====
    
    array = []
    @numbers.each do |num|
      index = @numbers.count(num)
      array.push(index)
    end
  
    max = array.max
    final = array.index(max)
    final = @numbers.at(final)

    @mode = final

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end

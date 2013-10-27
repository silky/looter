class UI

  def initialize(input, output)
    @input = input
    @output = output
  end

  def display_title(string)
    display_message "# #{string} #"
  end
  
  def display_subtitle(string)
    display_message "- #{string} -"
  end

  def choose_option(options)
    display_options(options)
    return read.to_i
  end

  def display_message(string)
    @output.puts string
  end

 private
  
  def display_options(options)
    options.each_with_index do |option, index|
      display_message "#{index+1}- #{option}"
    end
  end

  def read
    @input.gets
  end

end

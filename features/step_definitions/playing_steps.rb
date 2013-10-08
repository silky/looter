When(/^I start the game$/) do
  @game_process = GameProcess.new(IO.popen('./bin/game'))
end

Then(/^I should see the options$/) do |table|
  expected_options = as_list(table)
  actual_options = @game_process.read_options

  actual_options.should =~ expected_options
end

def as_list(table)
  table.raw.map(&:first)
end

class GameProcess
  OPTION_REGEXP = /^\d- (.*)/

  def initialize(process)
    @process = process
  end

  def read_options
    option_lines = output_lines.select { |line| OPTION_REGEXP.match(line) }
    return option_lines.map { |line| OPTION_REGEXP.match(line)[1] }
  end

 private

  def output_lines
    @process.readlines.map(&:chomp)
  end
end

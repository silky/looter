When(/^I start the game$/) do
  @game_process = GameProcess.new(IO.popen('./bin/game'))
end

Then(/^I should see game title "(.*?)"$/) do |expected_title|
  actual_title = @game_process.read_title

  actual_title.should == expected_title
end

Then(/^I should see aventure title "(.*?)"$/) do |expected_title|
  actual_title = @game_process.read_subtitle

  actual_title.should == expected_title
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
  TITLE_REGEXP = /^# (.*) #/
  SUBTITLE_REGEXP = /^- (.*) -/
  OPTION_REGEXP = /^\d- (.*)/

  def initialize(process)
    @raw_lines = process.readlines.map(&:chomp)
  end

  def read_title
    read_lines_matching(TITLE_REGEXP).first
  end

  def read_subtitle
    read_lines_matching(SUBTITLE_REGEXP).first
  end

  def read_options
    read_lines_matching(OPTION_REGEXP)
  end

 private

  def read_lines_matching(regexp)
    matching_lines = output_lines.select { |line| regexp.match(line) }
    return matching_lines.map { |line| regexp.match(line)[1] }
  end

  def output_lines
    @raw_lines
  end
end
